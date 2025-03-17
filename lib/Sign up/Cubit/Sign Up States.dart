abstract  class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  final String userId;
  SignUpSuccessState(this.userId);
}

class SignUpFailedState extends SignUpStates {
  final String errorMessage;
  SignUpFailedState(this.errorMessage);
}

class SignUpChangePasswordVisibilityState extends SignUpStates {}

class SignUpChangeSelectedState extends SignUpStates {}