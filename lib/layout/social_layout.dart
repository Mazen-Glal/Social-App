import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){

        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('News Feed'),
          ),
          body: ConditionalBuilder(
              condition: AppCubit.get(context).model != null,
              builder: (context) => Column(
            children: [
              if(AppCubit.get(context).model!.isVerified == false)
                Row(
                  children: [
                    const Icon(Icons.error_outline_outlined),
                    const SizedBox(width: 10),
                    const Text('please verify your email'),
                    Expanded(
                      child: TextButton(
                          child:const Text('SEND',style: TextStyle(color: Colors.blue)),
                          onPressed: (){
                            FirebaseAuth.instance.currentUser!.sendEmailVerification();
                          }
                      ),
                    )
                  ],
                ),
            ],
          ),
              fallback: (context) => const CircularProgressIndicator(),
          ),
    ),
    );
  }
}
