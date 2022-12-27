import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(InitialState());

  static LoginCubit get(context )=> BlocProvider.of(context);

  bool visibility = true;
  changeVisibilityState()
  {
    visibility = !visibility;
    emit(ChangeVisibilityState());
  }
}