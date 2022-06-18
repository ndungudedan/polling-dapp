import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_1/ui/poll_widget.dart';

import '../utils/assets.dart';
import 'newPoll/create_poll.dart';

class DashBooardScreen extends ConsumerWidget {
  const DashBooardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 3 * (size.width / 4),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              direction: Axis.horizontal,
              children: List.generate(12, (index) {
                return PollWidget();
              }),
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  int newIndex = index + 1;
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewPoll()));
                          }, child: Text('Create New Poll')),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Image.asset(
                          Assets.dash1,
                        ),
                        Text('Astronaut',),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
