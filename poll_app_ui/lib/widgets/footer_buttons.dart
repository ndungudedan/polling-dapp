import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FooterButtons extends StatelessWidget {
  Function()? onForwardPressed;
  Function()? onBackPressed;

  FooterButtons({required this.onForwardPressed, required this.onBackPressed});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [OutlinedButton(onPressed: onBackPressed, child: Text('Back')),
      Spacer(),
      OutlinedButton(
        style: OutlinedButton.styleFrom(),
        onPressed: onForwardPressed, child: Text('Next')),
      ],
    );
  }
}
