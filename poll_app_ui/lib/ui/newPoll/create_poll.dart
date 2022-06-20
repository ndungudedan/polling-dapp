import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/ui/newPoll/candidate_screen.dart';
import 'package:flutter_test_1/ui/newPoll/poll_screen.dart';
import 'package:flutter_test_1/ui/newPoll/submission_screen.dart';

import '../../providers/create_poll_provider.dart';
import '../../widgets/common_appbar.dart';
import '../../widgets/footer_buttons.dart';

class CreateNewPoll extends ConsumerStatefulWidget {
  @override
  CreateNewPollState createState() => CreateNewPollState();
}

class CreateNewPollState extends ConsumerState {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pollProvider = ref.watch(createPollProvider);

    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            commonAppBar(context),
            Flexible(
              child: SingleChildScrollView(
                  child: pollProvider.pollModel == null
                ? PollModelScreen(
                    banner: pollProvider.pollBanner,
                    pollModel: pollProvider.pollModel,
                  )
                : !pollProvider.submit
                    ? CandidateScreen(
                        banners: pollProvider.candidatesBanners,
                        candidates: pollProvider.candidates)
                    : SubmissionScreen(),
                ),
            ),
          ],
        ));
    
  }
}
