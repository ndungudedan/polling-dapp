import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/constants/constants.dart';
import 'package:flutter_test_1/utils/text_styles.dart';
import '../../providers/create_poll_provider.dart';
import '../../providers/wallet_connect_provider.dart';
import '../../widgets/snackbar_widget.dart';
import '../dashboard_screen.dart';
import '../poll_widget.dart';

class SubmissionScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SubmissionScreen> createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends ConsumerState<SubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final pollProvider = ref.watch(createPollProvider);
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: size.height / 4,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(),
          borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.memory(pollProvider.pollBanner!),
                Text.rich(TextSpan(
                    text: '${pollProvider.pollModel!.title}\n',
                    style: poppinsBold.copyWith(fontSize: 30),
                    children: [
                      TextSpan(
                          style: poppinsRegular.copyWith(fontSize: 20),
                          text: '${pollProvider.pollModel!.description}\n'),
                      TextSpan(
                          style: poppinsRegular.copyWith(fontSize: 10),
                          text:
                              '${DateTime.fromMillisecondsSinceEpoch(pollProvider.pollModel!.expiresAt)}\n'),
                    ]))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Poll Candidates Details',
            style: poppinsBold.copyWith(fontSize: 30),
          ),
        ),
        Wrap(
          children: List.generate(pollProvider.candidates.length, (index) {
            return PollCandidateWidget(
              image: pollProvider.candidatesBanners.elementAt(index)!,
              candidate: pollProvider.candidates.elementAt(index),
            );
          }),
        ),
        Center(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: kPrimaryColor
            ),
              onPressed: () async {
                if (await pollProvider.submitPollToChain()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.transparent,
                      content: SnackBarWidget(
                    title: 'Submission Successful',
                    message: 'Transaction is being executed',
                  )));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashBooardScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.transparent,
                      content: SnackBarWidget(
                    title: 'Submission Failed',
                    message: 'Please Try Again',
                  )));
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text('Submit Poll',style: poppinsMedium.copyWith(color: Colors.white),),
              )),
        )
      ],
    );
  }
}
