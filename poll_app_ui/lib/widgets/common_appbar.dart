import 'package:flutter/material.dart';
import 'package:flutter_test_1/constants/constants.dart';

import '../ui/newPoll/create_poll.dart';
import '../utils/text_styles.dart';

dynamic commonAppBar(BuildContext context,{bool showActions=false}) {
  return SizedBox(
    height: 70,
    child: AppBar(
      leadingWidth: 30,
      toolbarHeight: 70,
      automaticallyImplyLeading: !showActions,
      title: Text('Mkurugenzi Polling Dapp',
        style: poppinsBold.copyWith(color: Colors.white),
      ),
      actions: showActions ? [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                
                backgroundColor: kPrimaryLightColor
              ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreateNewPoll()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text('Create New Poll'),
                                  )),
          ),
        ),
      ] : [],
      bottom: CustomAppBar(),
    ),
  );
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30),
      child:  RichText(
                        text:
                          TextSpan(text: 'Cast your vote with confidence',
                                                      style: poppinsMedium.copyWith(
                                                        color: Colors.white),
),
                      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(10.0);

}
