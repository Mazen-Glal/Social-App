abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  late final String error;
  RegisterErrorState(this.error);
}

class LoadingCreateUserFireStoreState extends RegisterStates{}
class SuccessCreateUserFireStoreState extends RegisterStates{}
class ErrorCreateUserFireStoreState extends RegisterStates{
  late final String error;
  ErrorCreateUserFireStoreState(this.error);
}

class ChangeRegisterPasswordVisibilityState extends RegisterStates{}

