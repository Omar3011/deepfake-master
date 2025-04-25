import 'package:bloc/bloc.dart';
//import 'package:deep_faking_detection/core/cache/cache_helper.dart';

import 'package:deepfake/model/login_model.dart';
import 'package:deepfake/repo/auth_repo.dart';
import 'package:deepfake/view/home.dart';
import 'package:flutter/material.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  //final AuthRepository authrepo;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginPasswordsShowing = true;
  IconData suffixIcon = Icons.visibility;
  void changeLoginPasswordSuffixIcon() {
    isLoginPasswordsShowing = !isLoginPasswordsShowing;
    suffixIcon =
        isLoginPasswordsShowing ? Icons.visibility : Icons.visibility_off;
    emit(ChangeLoginPasswordSuffixIcon());
  }

  LoginModel? loginModel;
  // login method
  AuthRepo authRepo = AuthRepo();
  // SignUp
  void login(context) async {
    print(emailController.text);
    print(passwordController.text);

    final result = await authRepo.signIn({
      "users_email": emailController.text,
      "users_password": passwordController.text,
    });
    if (result["status"] == "success") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    print(result);
  }
}
