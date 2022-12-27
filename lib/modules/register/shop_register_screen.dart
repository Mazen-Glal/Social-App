import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_cubit/cubit.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {

          } else if (state is RegisterErrorState) {

          }
        },

        builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'register now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          onFieldSubmitted: (value) {},
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your  name.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: 'User Name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          onFieldSubmitted: (value) {},
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your Email Address.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: 'E-mail Address',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText:
                          RegisterCubit.get(context).isPassword ? true : false,
                          onChanged: (value) {},
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short..';
                            }
                            return null;
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: GestureDetector(
                                child: RegisterCubit.get(context).isPassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                onTap: () {
                                  RegisterCubit.get(context)
                                      .changePasswordVisibility();
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          onFieldSubmitted: (value) {},
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone.';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          decoration: InputDecoration(
                              hintText: 'Phone',
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          width: double.infinity,
                          height: 40,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {

                              }
                            },
                            child: state == RegisterLoadingState()
                                ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                                : const Text(
                              'REGISTER',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
