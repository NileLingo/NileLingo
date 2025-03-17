import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Constants/Constant.dart';
import '../Services/Login Api.dart';
import 'Login States.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool obscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void changePasswordVisibility() {
    obscureText = !obscureText;
    emit(LoginChangePasswordVisibilityState());
  }

  Future<void> userLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    emit(LoginLoadingState());

    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      print("🔐 Email: $email, Password: $password");
      if (email.isEmpty || password.isEmpty) {
        emit(LoginFailedState("Email and password cannot be empty."));
        return;
      }

      userId  = (await LoginApi.loginUser(email, password))!;

      if (userId != null && userId.isNotEmpty) {
        print("🔐 Login successful: $userId");
        emit(LoginSuccessState(userId));
      } else {
        emit(LoginFailedState("Invalid email or password."));
      }
    } catch (e) {
      emit(LoginFailedState("Login failed: $e"));
    }
  }

}
