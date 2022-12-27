import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // late LoginModel loginModel;
  // void userRegister({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String phone,
  // })
  // {
  //   emit(RegisterLoadingState());
  //   DioHelper.postData(
  //     url: LOGIN,
  //     data: {
  //       'name':name,
  //       'email':email,
  //       'password':password,
  //       'phone':phone,
  //     },
  //   ).then((value) {
  //       loginModel = LoginModel.fromJson(value.data);
  //       emit(RegisterSuccessState(loginModel));
  //   }).catchError((error){
  //       debugPrint(error.toString());
  //       emit(RegisterErrorState(error.toString()));
  //   });
  // }


  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    emit(ChangeRegisterPasswordVisibilityState());
  }

}

