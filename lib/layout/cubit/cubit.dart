import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/create_user_model/create_user_model.dart';
import 'package:social_app/shared/components/components.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(InitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  late CreateUserModel? model ;
  void getUserData(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value){
      print(value.data());
      model = CreateUserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }
}