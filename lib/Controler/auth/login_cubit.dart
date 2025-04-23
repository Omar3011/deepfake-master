import 'package:bloc/bloc.dart';
//import 'package:deep_faking_detection/core/cache/cache_helper.dart';

import 'package:deepfake/model/login_model.dart';
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
  void login() async {
    /* emit(LoginLoadingState());
    final result = await authrepo.login(
      userName: emailController.text,
      password: passwordController.text,
    );
    result.fold((l) => emit(LoginErrorState(l)), (r) async {
      loginModel = r;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(r.idToken);
      await sl<CacheHelper>()
          .saveData(key: Apikeys.id, value: decodedToken[Apikeys.id]);
      await sl<CacheHelper>().saveData(
        key: Apikeys.idToken,
        value: r.idToken,
      ); 
      emit(LoginSuccessState());
    });*/
  }
}
