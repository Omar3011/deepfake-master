import 'package:flutter/material.dart';
//import '../utils/validators.dart'; // ✅ Import reusable validators

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  SignInForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          _buildOvalFormField(
            emailController,
            'Email',
            Icons.email,
            // validator: Validators.validateEmail
          ),
          SizedBox(height: 10),
          _buildOvalFormField(
            passwordController,
            'Password',
            Icons.lock,
            obscureText: true,
            // validator: Validators.validatePassword,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /// **Reusable Oval Form Field**
  Widget _buildOvalFormField(
    TextEditingController controller,
    String labelText,
    IconData icon, {
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      height: 58,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, size: 24),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
