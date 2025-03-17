abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String userId;
  LoginSuccessState(this.userId);
}

class LoginFailedState extends LoginStates {
  final String errorMessage;
  LoginFailedState(this.errorMessage);
}
class LoginChangePasswordVisibilityState extends LoginStates {}