import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nile_lingo/Constants/Constant.dart';

import '../Service/Sign UP API.dart';
import 'Sign Up States.dart';


class SignUPCubit extends Cubit<SignUpStates> {
  SignUPCubit() : super(SignUpInitialState());

  static SignUPCubit get(context) => BlocProvider.of(context);

  bool obscureText = true;
  bool isSelected = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changeSelected() {
    isSelected = !isSelected;
    emit(SignUpChangeSelectedState());
  }

  void changePasswordVisibility() {
    obscureText = !obscureText;
    emit(SignUpChangePasswordVisibilityState());
  }

  Future<void> userSignUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(SignUpLoadingState());

    try {
      String email = emailController.text.trim();
      String username = nameController.text.trim();
      String password = passwordController.text.trim();

      userId  = (await SignUPApi.registerUser(email, username, password))!;

      if (userId != null) {
        emit(SignUpSuccessState(userId));
      } else {
        emit(SignUpFailedState("Registration failed. Please try again."));
      }
    } catch (e) {
      emit(SignUpFailedState("Error: $e"));
    }
  }
}
