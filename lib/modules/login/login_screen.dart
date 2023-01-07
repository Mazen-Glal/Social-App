import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState)
          {
            CacheHelper.saveData("UId", state.uid);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const SocialLayout()
                ),
                    (route) => false
            );
            Fluttertoast.showToast(msg: 'Login Success State',backgroundColor: Colors.green);
          }
          else if (state is LoginErrorState)
          {
            Fluttertoast.showToast(msg: state.error,backgroundColor: Colors.redAccent);
          }
        },

        builder:(context,state)=> Scaffold(
          appBar: AppBar(
            title: const Text("Login Page"),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("LOGIN",style: TextStyle(fontSize: 35,color: Colors.black,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("login now to communicate with friends",style: TextStyle(fontSize: 15,color: Colors.grey)),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value){

                    },
                    onChanged: (value){

                    },
                    onTap: (){

                    },
                    validator: (value){
                      if (value!.isEmpty) {
                        return "Email Address must be not empty";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon:const Icon(Icons.lock),
                      hintText: "Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: LoginCubit.get(context).visibility,
                    onFieldSubmitted: (value){

                    },
                    onChanged: (value){

                    },
                    onTap: (){

                    },
                    validator: (value){
                      if (value!.isEmpty) {
                        return "password must be not empty";
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          child: LoginCubit.get(context).visibility ?  const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                          onTap: (){
                            LoginCubit.get(context).changeVisibilityState();
                          },
                        ),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        )
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    width: double.infinity,
                    child: MaterialButton(
                      height: 50,
                      child:const Text("LOGIN",style: TextStyle(fontSize: 18,color: Colors.white)),
                      onPressed: (){
                        if(formKey.currentState!.validate())
                        {
                          LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text
                          );
                        }
                      }
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don`t have an account ?",style: TextStyle(fontSize: 17),),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                          },
                          child: const Text("REGISTER",style: TextStyle(fontSize: 17))
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
