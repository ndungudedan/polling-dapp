import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/models/poll_model.dart';
import 'package:flutter_test_1/utils/text_styles.dart';

import '../providers/create_poll_provider.dart';

class NewPollWidget extends ConsumerWidget {
  final PollModel pollModel;
  const NewPollWidget({required this.pollModel});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            pollModel.banner,
            height: size.height / 5,
            width: size.width / 5,
          ),
          Text(
            pollModel.title,
          ),
          Text(pollModel.description),
          OutlinedButton(onPressed: () {}, child: const Text('View Candidate'))
        ],
      ),
    );
  }
}

class PollCandidateWidget extends ConsumerWidget {
  final PollCandidateModel candidate;
  final Uint8List image;

  const PollCandidateWidget({required this.candidate, required this.image});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final pollProvider = ref.watch(createPollProvider);

    return Container(
      width: size.width / 5,
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 22),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.memory(
            image,
            height: size.height / 3,
            width: size.width / 3,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              candidate.title,
              style: poppinsBold.copyWith(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(candidate.description,
            style: poppinsMedium,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.red
                                ),
                  onPressed: () {
                    pollProvider.deletePollCandidate(candidate);
                  },
                  child: const Text('Delete')),
            ),
          )
        ],
      ),
    );
  }
}
