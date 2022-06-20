import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_1/constants/constants.dart';
import 'package:flutter_test_1/utils/text_styles.dart';

class SnackBarWidget extends StatelessWidget {
  final String title;
  final String message;
  final bool isError;

  SnackBarWidget(
      {this.isError = false, required this.message, required this.title});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      height: size.height/8,
      width: size.width/4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isError ? Colors.red : kPrimaryColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: poppinsBold.copyWith(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              message,
              style: poppinsMedium.copyWith(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
