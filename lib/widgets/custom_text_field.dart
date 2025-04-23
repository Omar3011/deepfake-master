import 'package:flutter/material.dart';

class OvalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final IconData? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool isPassword;

  const OvalTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, size: 24, color: Colors.purple),
          suffixIcon: Icon(suffixIcon),
          // isPassword
          //     ? IconButton(
          //         icon: Icon(
          //           obscureText ? Icons.visibility_off : Icons.visibility,
          //           color: Colors.purple,
          //         ),
          //         onPressed: () {
          //           // This requires a StatefulWidget to update obscureText
          //         },
          //       )
          //     : null,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25), // ✅ Oval Shape
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.purple, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
