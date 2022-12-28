import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(InitialState());

  static LoginCubit get(context )=> BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password
  }){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      debugPrint(value.user!.email);
      debugPrint(value.user!.uid);
      emit(LoginSuccessState());
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  bool visibility = true;
  changeVisibilityState()
  {
    visibility = !visibility;
    emit(ChangeVisibilityState());
  }
}