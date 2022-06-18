import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/models/poll_model.dart';
import 'package:flutter_test_1/utils/app_theme.dart';
import 'package:flutter_test_1/utils/assets.dart';
import 'package:flutter_test_1/utils/text_styles.dart';

import '../providers/create_poll_provider.dart';

class PollWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Assets.dash1,
            height: size.height / 5,
            width: size.width / 5,
          ),
          Text(
            'Astronaut',
          ),
          Text('Descriptive descriptions'),
          OutlinedButton(onPressed: () {}, child: Text('View Details'))
        ],
      ),
    );
  }
}

class PollCandidateWidget extends ConsumerWidget {
  final PollCandidateModel candidate;
  final Uint8List image;

  PollCandidateWidget({required this.candidate, required this.image});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final pollProvider = ref.watch(createPollProvider);

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.memory(
            image,
            height: size.height / 5,
            width: size.width / 5,
          ),
          Text(
            candidate.title,
          ),
          Text(candidate.description),
          OutlinedButton(
              onPressed: () {
                pollProvider.deletePollCandidate(candidate);
              },
              child: Text('Delete'))
        ],
      ),
    );
  }
}
