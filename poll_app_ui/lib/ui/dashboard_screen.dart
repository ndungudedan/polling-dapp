import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/constants/constants.dart';
import 'package:flutter_test_1/ui/view_canidates_screen.dart';
import 'package:flutter_test_1/utils/text_styles.dart';
import '../models/poll_model.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/common_appbar.dart';

class DashBooardScreen extends ConsumerWidget {
  const DashBooardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
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
                    return ListView.builder(
                        itemCount: polls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Image.network(
                                  polls.elementAt(index).banner,
                                ),
                                Text(polls.elementAt(index).title),
                              ],
                            ),
                          );
                        });
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
          SizedBox(height: 5,),
          
          Text(
            pollModel.title,
            style: poppinsRegular.copyWith(color: Colors.white,fontSize: 16),
          ),
          SizedBox(height: 5,),
          Text(
            pollModel.description,
            style: poppinsRegular.copyWith(color: Colors.white,fontSize: 12),
          ),
          SizedBox(height: 10,),
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white
              ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewCandidatesScreen(
                              pollModel: pollModel, pollIndex: index)));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text('View Candidates',style: poppinsMedium.copyWith(color: kPrimaryColor),),
                )),
          )
        ],
      ),
    );
  }
}
