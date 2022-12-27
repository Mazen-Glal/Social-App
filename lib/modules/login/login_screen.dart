import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/shop_register_screen.dart';
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
        listener: (context,state){},
        builder:(context,state)=> Scaffold(
          appBar: AppBar(
            title: const Text("Login Page"),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
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
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Email Address",
                      border: OutlineInputBorder()
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
                        border: const OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      height: 50,
                      color: Colors.blue,
                      child:const Text("LOGIN",style: TextStyle(fontSize: 18,color: Colors.white)),
                      onPressed: (){
                        if(formKey.currentState!.validate())
                        {

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
