//import 'package:deep_faking_detection/utils/validators.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  SignUpForm({
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          _buildOvalFormField(
            widget.firstNameController,
            'First Name',
            Icons.person,
            // validator: (value) =>
            //     Validators.validateRequired(value, "First Name"),
          ),
          SizedBox(height: 10),
          _buildOvalFormField(
            widget.lastNameController,
            'Last Name',
            Icons.person_outline,
            // validator: (value) =>
            //     Validators.validateRequired(value, "Last Name"),
          ),
          SizedBox(height: 10),
          _buildOvalFormField(
            widget.emailController,
            'Email',
            Icons.email,
            // validator: Validators.validateEmail
          ),
          SizedBox(height: 10),
          _buildOvalFormField(
            widget.usernameController,
            'Username',
            Icons.account_circle,
            // validator: (value) =>
            //     Validators.validateRequired(value, "Username"),
          ),
          SizedBox(height: 10),
          _buildOvalFormField(
            widget.passwordController,
            'Password',
            Icons.lock,
            obscureText: true,
            // validator: Validators.validatePassword
          ),
          SizedBox(height: 10),
          _buildOvalFormField(
            widget.confirmPasswordController,
            'Confirm Password',
            Icons.lock_outline,
            obscureText: true,
            // validator: (value) => Validators.validatePasswordMatch(
            //     value, widget.passwordController.text),
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
