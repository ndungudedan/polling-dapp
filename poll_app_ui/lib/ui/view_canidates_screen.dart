import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/constants/constants.dart';
import 'package:flutter_test_1/models/poll_model.dart';
import 'package:flutter_test_1/widgets/common_appbar.dart';
import '../providers/dashboard_provider.dart';
import '../providers/wallet_connect_provider.dart';
import '../utils/assets.dart';
import '../utils/text_styles.dart';
import '../widgets/snackbar_widget.dart';
import 'newPoll/create_poll.dart';

class ViewCandidatesScreen extends ConsumerStatefulWidget {
  final PollModel pollModel;
  final int pollIndex;
  const ViewCandidatesScreen(
      {required this.pollModel, required this.pollIndex, Key? key})
      : super(key: key);

  @override
  ViewCandidatesScreenState createState() => ViewCandidatesScreenState();
}

class ViewCandidatesScreenState extends ConsumerState<ViewCandidatesScreen> {
  late PollModel pollModel;
  late int pollIndex;

  @override
  void initState() {
    pollIndex = widget.pollIndex;
    pollModel = widget.pollModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final walletProvider = ref.watch(walletConnectProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (walletProvider.currentChainId != WalletConnectProvider().chainId &&
          mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 10),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: SnackBarWidget(
              title: 'Change your Wallet Chain to Polygon Mumbai',
              message:
                  'This dapp works on the Ethereum Polygon Mumbai Testnet network',
              isError: true,
            )));
      }
    });

    final pollCandidatesFuture = ref.watch(pollCandidatesProvider(pollIndex));
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonAppBar(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    height: size.height / 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            pollModel.banner,
                            height: size.height / 4,
                            width: size.width / 3,
                            errorBuilder: (context, object, stack) {
                              return Container(
                                color: Colors.grey,
                                height: size.height / 4,
                                width: size.width / 3,
                                child: Center(
                                  child: Text(
                                    'Failed to load Image',
                                    style: poppinsMedium,
                                  ),
                                ),
                              );
                            },
                          ),
                          Expanded(
                            child: Text.rich(TextSpan(
                                text: '${pollModel.title}\n',
                                style: poppinsBold.copyWith(fontSize: 25),
                                children: [
                                  TextSpan(
                                      style:
                                          poppinsRegular.copyWith(fontSize: 20),
                                      text: '${pollModel.description}\n\n'),
                                  TextSpan(
                                      style:
                                          poppinsRegular.copyWith(fontSize: 10),
                                      text:
                                          '${DateTime.fromMillisecondsSinceEpoch(pollModel.expiresAt)}\n'),
                                ])),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Poll Candidates',
                      style: poppinsBold.copyWith(fontSize: 30),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                        child: pollCandidatesFuture.when(
                      data: (polls) => Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        direction: Axis.horizontal,
                        children: List.generate(polls.length, (index) {
                          return PollVoteCandidateWidget(
                            pollIndex: pollIndex,
                            index: index,
                            candidate: polls.elementAt(index),
                          );
                        }),
                      ),
                      loading: () => Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator())),
                      error: (e, st) => Text('Error: $e'),
                    )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PollVoteCandidateWidget extends ConsumerWidget {
  final PollCandidateModel candidate;
  final int pollIndex;
  final int index;
  PollVoteCandidateWidget(
      {required this.candidate, required this.index, required this.pollIndex});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final pollProvider = ref.watch(dashboardPollProvider);
    final hasVoted =
        pollProvider.myVotes.any((element) => element.pollIndex == pollIndex);

    return Container(
      height: size.height / 3,
      width: size.width / 3,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                candidate.banner,
                height: size.height / 6,
                width: size.width / 3,
                errorBuilder: (context, object, stack) {
                  return Container(
                    color: Colors.grey,
                    height: size.height / 6,
                    width: size.width / 3,
                    child: Center(
                      child: Text(
                        'Failed to load Image',
                        style: poppinsMedium,
                      ),
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(candidate.totalVotes.toString(),style: poppinsBold.copyWith(color: kPrimaryColor,fontSize: 20),),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            candidate.title,
            style: poppinsRegular.copyWith(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            candidate.description,
            style: poppinsRegular.copyWith(color: Colors.white, fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child:
            hasVoted ?
            Icon(Icons.check_circle_outline_rounded,color: Colors.green,size: 50,)
            :
             OutlinedButton(
                style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await pollProvider.voteForCandidate(pollIndex, index);
                },
                child: Text(
                  'Vote',
                  style: poppinsMedium.copyWith(color: kPrimaryColor),
                )),
          )
        ],
      ),
    );
  }
}
