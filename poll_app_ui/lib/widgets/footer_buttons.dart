import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_1/constants/constants.dart';
import 'package:flutter_test_1/utils/text_styles.dart';

class FooterButtons extends StatelessWidget {
  Function()? onForwardPressed;
  Function()? onBackPressed;

  FooterButtons({required this.onForwardPressed, required this.onBackPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          //OutlinedButton(onPressed: onBackPressed, child: Text('Back',style: poppinsBold.copyWith(color: Colors.white))),
          Spacer(),
          OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: kPrimaryColor),
              onPressed: onForwardPressed,
              child: Text(
                'Next',
                style: poppinsMedium.copyWith(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
