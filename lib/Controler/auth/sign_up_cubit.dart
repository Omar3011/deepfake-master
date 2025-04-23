// ignore_for_file: non_constant_identifier_names


import 'package:deepfake/Controler/auth/sign_up_state.dart';
import 'package:deepfake/model/sing_up_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  //passowrd text field
  bool isLoginPasswordsShowing = true;
  IconData suffixIcon = Icons.remove_red_eye_outlined;
  void changeLoginPasswordSuffixIcon() {
    isLoginPasswordsShowing = !isLoginPasswordsShowing;

    suffixIcon =
        isLoginPasswordsShowing ? Icons.visibility_off : Icons.visibility_off;
    emit(ChangeLoginPasswordSuffixIcon());
  }

  //* confirm password text field
  TextEditingController confirmPasswordController = TextEditingController();
  bool isConfirmPasswordsShowing = true;
  IconData suffixIconConfirmPassword = Icons.remove_red_eye_outlined;
  void changeConfirmPasswordSuffixIcon() {
    isConfirmPasswordsShowing = !isConfirmPasswordsShowing;
    // suffixIconConfirmPassword =
    //     isConfirmPasswordsShowing ? Icons.visibility : Icons.visibility_off;
    emit(ChangeConfirmPasswordSuffixIcon());
  }

  //! SignUp method
  //final AuthRepository authrepo;

  SignUpModel? signUpModel;
  // SignUp
  /* void signUp() async {
    final result = await authrepo.signUp(
        confirmPassword: confirmPasswordController.text,
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: userNameController.text);
    result.fold((l) => emit(SignUpError(l)), (r) async {
      signUpModel = r;
      emit(SignUpSuccess(r.message));
    }); */
  }

