import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/ui/dashboard_screen.dart';

import '../../providers/create_poll_provider.dart';
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

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: size.height / 4,
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                Image.memory(pollProvider.pollBanner!),
                Text.rich(TextSpan(
                    text: '${pollProvider.pollModel!.title}\n\n',
                    children: [
                      TextSpan(
                          text: '${pollProvider.pollModel!.description}\n'),
                      TextSpan(
                          text:
                              '${DateTime.fromMillisecondsSinceEpoch(pollProvider.pollModel!.expiresAt)}\n'),
                    ]))
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Wrap(
            children: List.generate(pollProvider.candidates.length, (index) {
              return PollCandidateWidget(
                image: pollProvider.candidatesBanners.elementAt(index)!,
                candidate: pollProvider.candidates.elementAt(index),
              );
            }),
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashBooardScreen()));
              },
              child: Text('Submit'))
        ],
      ),
    );
  }
}
