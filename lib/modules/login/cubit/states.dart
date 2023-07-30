abstract class LoginStates {}

class InitialState extends LoginStates{}

class ChangeVisibilityState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  late final dynamic uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginStates{
  late final String error;
  LoginErrorState(this.error);
}