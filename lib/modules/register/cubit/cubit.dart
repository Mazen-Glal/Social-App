import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/create_user_model/create_user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      debugPrint(value.user!.email);
      debugPrint(value.user!.uid);
      createUserFireStore(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid
      );
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }


  void createUserFireStore({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){
    CreateUserModel model = CreateUserModel(
        name       : name,
        email      : email,
        phone      : phone,
        uId        : uId,
        isVerified : false
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      emit(SuccessCreateUserFireStoreState());
    }).catchError((error){
      emit(ErrorCreateUserFireStoreState(error.toString()));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}
