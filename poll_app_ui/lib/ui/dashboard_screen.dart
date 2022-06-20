import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/constants/constants.dart';
import 'package:flutter_test_1/providers/wallet_connect_provider.dart';
import 'package:flutter_test_1/ui/view_canidates_screen.dart';
import 'package:flutter_test_1/utils/text_styles.dart';
import '../models/poll_model.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/common_appbar.dart';
import '../widgets/snackbar_widget.dart';

class DashBooardScreen extends ConsumerStatefulWidget {
  const DashBooardScreen({Key? key}) : super(key: key);

  @override
  DashboardSCreenState createState() => DashboardSCreenState();
}

class DashboardSCreenState extends ConsumerState<DashBooardScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final walletProvider = ref.watch(walletConnectProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
          if (walletProvider.currentChainId != WalletConnectProvider().chainId &&
        mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
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

    final allPollsFuture = ref.watch(allPollsProvider);
    final myPollsFuture = ref.watch(myPollsProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          commonAppBar(context, showActions: true),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 3 * (size.width / 4),
                    child: allPollsFuture.when(
                      data: (polls) {
                        if (polls.isEmpty) {
                          return Center(
                            child: Text(
                              'No Polls Yet',
                              style: poppinsBold.copyWith(
                                  color: kPrimaryColor, fontSize: 30),
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          child: Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            direction: Axis.horizontal,
                            children: List.generate(polls.length, (index) {
                              return PollWidget(
                                index: index,
                                pollModel: polls.elementAt(index),
                              );
                            }),
                          ),
                        );
                      },
                      loading: () => const Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator())),
                      error: (e, st) => Text('Error: $e'),
                    )),
                Flexible(
                    child: myPollsFuture.when(
                  data: (polls) {
                    if (polls.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Your Polls Appear here',
                            style: poppinsBold.copyWith(color: kPrimaryColor),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          Text(
                              'Your Polls',
                              style: poppinsBold.copyWith(color: kPrimaryColor),
                            ),
                            SizedBox(height: 10,),
                          ListView.builder(
                            shrinkWrap: true,
                              itemCount: polls.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: PollWidget(
                                      index: index,
                                      pollModel: polls.elementAt(index),
                                    ),
                                );
                              }),
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())),
                  error: (e, st) => Text('Error: $e'),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PollWidget extends ConsumerWidget {
  final PollModel pollModel;
  final int index;
  PollWidget({required this.pollModel, required this.index});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
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
                pollModel.banner,
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
                  child: Text(pollModel.totalVotes.toString(),style: poppinsBold.copyWith(color: kPrimaryColor,fontSize: 20),),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            pollModel.title,
            style: poppinsRegular.copyWith(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            pollModel.description,
            style: poppinsRegular.copyWith(color: Colors.white, fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Center(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewCandidatesScreen(
                                pollModel: pollModel, pollIndex: index)));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text(
                      'View Candidates',
                      style: poppinsMedium.copyWith(color: kPrimaryColor),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
