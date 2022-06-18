import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BorderedTextField extends StatelessWidget {
  final String? hintText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? labelText;
  final String? initialValue;
  final Color? fillColor;
  final bool? enabled;
  final TextInputAction textInputAction;
  final TextInputType? inputType;
  final FocusNode? currentfocus;
  final FocusNode? nextfocus;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final Function(String val)? onChanged;
  final Function()? onTap;
  final Function()? toggleVisibility;
  final bool obscured;
  final bool showSuffix;
  final int? maxLines;
  final formKey;

  BorderedTextField(
      {this.hintText,
      this.onTap,
      this.maxLines,
      this.toggleVisibility,
      this.showSuffix = false,
      this.obscured = false,
      this.textInputAction = TextInputAction.next,
      this.helperText,
      this.suffix,
      this.enabled,
      this.prefixIcon,
      this.onChanged,
      this.labelText,
      this.initialValue,
      this.fillColor,
      this.controller,
      this.contentPadding,
      this.currentfocus,
      this.inputType,
      this.nextfocus,
      this.formKey});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: inputType,
      initialValue: initialValue,
      onTap: onTap,
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      cursorColor: kPrimaryColor,
      obscureText: obscured,
      onFieldSubmitted: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill field';
        }
        return null;
      },
      decoration: InputDecoration(
          focusColor: kPrimaryColor,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor)),
          enabled: enabled ?? false,
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          suffixIcon: showSuffix
              ? IconButton(
                  onPressed: toggleVisibility,
                  icon: Icon(
                    obscured ? Icons.visibility : Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
                )
              : SizedBox()),
    );
  }
}
