import 'package:deepfake/Controler/auth/login_cubit.dart';
import 'package:deepfake/Controler/auth/login_state.dart';
import 'package:deepfake/view/auth/sign_up_screen.dart';
import 'package:deepfake/view/home.dart';
import 'package:deepfake/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  String? registeredEmail;
  String? registeredPassword;

  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final args =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
  //   if (args != null) {
  //     registeredEmail = args['email'];
  //     registeredPassword = args['password'];
  //     /// ✅ Pre-fill email & password for better UX
  //     emailController.text = registeredEmail ?? '';
  //     passwordController.text = registeredPassword ?? '';
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: BlocProvider(
          create: (context) => LoginCubit(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Column(
                    children: [
                      const SizedBox(height: 40),

                      /// **Sign-In Form**
                      Form(
                        key: BlocProvider.of<LoginCubit>(context).loginKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            OvalTextField(
                              controller:
                                  BlocProvider.of<LoginCubit>(
                                    context,
                                  ).emailController,
                              labelText: 'Email',
                              icon: Icons.email,
                              // validator: (value) =>
                              //     validateEmailMatch(value, registeredEmail),
                            ),
                            const SizedBox(height: 15),
                            OvalTextField(
                              controller:
                                  BlocProvider.of<LoginCubit>(
                                    context,
                                  ).passwordController,
                              labelText: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                              // validator: (value) => validatePasswordMatch(
                              //     value, registeredPassword),
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// **Forgot Password?**
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Forgot Password feature coming soon!',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// **Sign-In Button**
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginCubit>(
                                context,
                              ).login(context);
                              //  if (BlocProvider.of<LoginCubit>(
                              //      context,
                              //    ).loginKey.currentState!.validate()) {

                              //      Navigator.push(
                              //
                              //       context,

                              //  );
                              //    }
                              // if (_formKey.currentState!.validate()) {
                              //   Navigator.pushReplacementNamed(
                              //       context, '/home'); // ✅ Navigate to home
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// **Sign-Up Redirect**
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            ); // ✅ Navigate to SignUpScreen
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **✅ Validate Email Match**
  String? validateEmailMatch(String? value, String? registeredEmail) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (value != registeredEmail) {
      return 'Email does not match the registered email';
    }
    return null;
  }

  /// **✅ Validate Password Match**
  String? validatePasswordMatch(String? value, String? registeredPassword) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value != registeredPassword) {
      return 'Password does not match the registered password';
    }
    return null;
  }
}
