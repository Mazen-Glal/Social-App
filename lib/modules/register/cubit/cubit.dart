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
    ).then((value) async {
      debugPrint(value.user!.email);
      debugPrint(value.user!.uid);
      await createUserFireStore(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid
      );
      emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  Future<void> createUserFireStore({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) async {
    CreateUserModel model = CreateUserModel(
        name       : name,
        email      : email,
        phone      : phone,
        uId        : uId,
        image      : 'https://img.freepik.com/free-photo/serious-afro-american-woman-points-away-blank-space_273609-45546.jpg?t=st=1673107190~exp=1673107790~hmac=d0011d0bc8ceb145f8d3d87e09f9ad6d99e05827e36dba9d27834808793e9abd%27' ,
        cover      : 'https://img.freepik.com/premium-vector/facebook-abstract-polygonal-cover-template_52246-69.jpg?w=740',
        bio        : 'write your bio',
        isVerified : false
    );
    await FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
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
