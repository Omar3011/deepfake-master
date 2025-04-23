import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isObscure;
  final TextInputType keyBoardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final TextEditingController controller;
  final int? maxLength;
  CustomTextFormFiled({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.isObscure = false,
    this.keyBoardType = TextInputType.text,
    required this.controller,
    required this.validator,
    this.onChange,
    this.maxLength,
  });
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: TextFormField(
        focusNode: _focusNode,
        onChanged: onChange,
        //maxLength: maxLength,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
          filled: true,
          fillColor: Colors.transparent,
        ),
        style: const TextStyle(fontSize: 15, color: Colors.black),
        keyboardType: keyBoardType,
        obscureText: isObscure,
        validator: validator,
        controller: controller,
        autofocus: false,
      ),
    );
  }
}
