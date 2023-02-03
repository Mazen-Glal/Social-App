import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 195,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: NetworkImage('${userModel!.cover}'),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 59,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                  '${userModel.name}',
                  style:  const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  )
              ),
              Text(
                  '${userModel.bio}',
                  style:  Theme.of(context).textTheme.caption
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            const Text(
                                '100',
                                style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                )
                            ),
                            Text(
                                'Posts',
                                style:  Theme.of(context).textTheme.caption
                            ),
                          ],
                        ),
                        onTap: () {

                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            const Text(
                                '265',
                                style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                )
                            ),
                            Text(
                                'Photos',
                                style:  Theme.of(context).textTheme.caption
                            ),
                          ],
                        ),
                        onTap: () {

                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            const Text(
                                '10K',
                                style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                )
                            ),
                            Text(
                                'followers',
                                style:  Theme.of(context).textTheme.caption
                            ),
                          ],
                        ),
                        onTap: () {

                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            const Text(
                                '64',
                                style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                )
                            ),
                            Text(
                                'followings',
                                style:  Theme.of(context).textTheme.caption
                            ),
                          ],
                        ),
                        onTap: () {

                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {

                        },
                        child: const Text('Add Photos',style: TextStyle(color: Colors.blue,))
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(),));
                      },
                      child:const  Icon(Icons.edit,color: Colors.blue,)
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
