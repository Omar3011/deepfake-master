import 'package:deepfake/Controler/auth/sign_up_cubit.dart';
import 'package:deepfake/Controler/auth/sign_up_state.dart';
import 'package:deepfake/view/auth/sign_in_sccreen.dart';
import 'package:deepfake/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () =>
              FocusScope.of(
                context,
              ).unfocus(), // ✅ Dismiss keyboard when tapping outside
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: BlocProvider(
          create: (context) => SignUpCubit(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),

                      /// **Sign-Up Form**
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            key:
                                BlocProvider.of<SignUpCubit>(context).signUpKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                OvalTextField(
                                  controller:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).firstNameController,
                                  labelText: 'First Name',
                                  icon: Icons.person,
                                  validator: (value) {
                                    /* Validators.validateRequired(
                                          value, 'First Name'), */
                                  },
                                ),
                                const SizedBox(height: 15),

                                OvalTextField(
                                  controller:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).lastNameController,
                                  labelText: 'Last Name',
                                  icon: Icons.person_outline,
                                  validator: (value) {
                                    /*  Validators.validateRequired(
                                          value, 'Last Name'), */
                                  },
                                ),
                                const SizedBox(height: 15),
                                OvalTextField(
                                  controller:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).emailController,
                                  labelText: 'Email',
                                  icon: Icons.email,
                                  validator: (ValueKey) {},
                                ),
                                const SizedBox(height: 15),
                                OvalTextField(
                                  controller:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).userNameController,
                                  labelText: 'Username',
                                  icon: Icons.account_circle,
                                  validator: (value) {
                                    /*  Validators.validateRequired(
                                          value, 'Username'), */
                                  },
                                ),
                                const SizedBox(height: 15),
                                OvalTextField(
                                  suffixIcon:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).suffixIcon,
                                  controller:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).passwordController,
                                  labelText: 'Password',
                                  icon: Icons.lock_outline,
                                  obscureText:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).isLoginPasswordsShowing,
                                  // validator: Validators.validatePassword,
                                  isPassword:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).isLoginPasswordsShowing,
                                ),
                                const SizedBox(height: 15),
                                OvalTextField(
                                  controller:
                                      BlocProvider.of<SignUpCubit>(
                                        context,
                                      ).confirmPasswordController,
                                  labelText: 'Confirm Password',
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                  validator: (value) {
                                    /*  Validators.validatePasswordMatch(
                                          value, passwordController.text),
                                  isPassword: true, */
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// **Sign-Up Button & Sign-In Text Positioned at the Bottom**
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  /// ✅ Navigate to Sign-In Page & Pass Email & Password
                                  context.read<SignUpCubit>().signUp();
                                  //     if (_formKey.currentState!.validate()) {
                                  //   }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      25,
                                    ), // ✅ Matching Sign-In Button
                                  ),
                                ),
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),
                                ); // ✅ Navigate to SignInScreen
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Sign In",
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
