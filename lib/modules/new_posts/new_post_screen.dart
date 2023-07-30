import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/colors.dart';
class NewPostsScreen extends StatelessWidget {
  NewPostsScreen({Key? key}) : super(key: key);

  final  textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) => Scaffold(
        appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions:  [
              TextButton(
                child: const Text('Post'),
                onPressed: (){
                  if(AppCubit.get(context).postImage == null)
                  {
                    AppCubit.get(context).createPostWithoutImage(
                        dateTime: TimeOfDay.now().format(context),
                        text: textController.text
                    );
                  }else{
                    AppCubit.get(context).createPostWithImage(
                        dateTime: TimeOfDay.now().format(context),
                        text: textController.text
                    );
                  }
                },
              )
            ]
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('https://img.freepik.com/free-photo/serious-afro-american-woman-points-away-blank-space_273609-45546.jpg?t=st=1673107190~exp=1673107790~hmac=d0011d0bc8ceb145f8d3d87e09f9ad6d99e05827e36dba9d27834808793e9abd%27'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Mazen Glal',style: TextStyle(fontWeight: FontWeight.w900),),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                  },
                  onChanged: (value) {
                  },
                  keyboardType: TextInputType.text,
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'write your post...',
                    border: InputBorder.none
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if(AppCubit.get(context).postImage != null)
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: FileImage(AppCubit.get(context).postImage!),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 16.0,
                          backgroundColor: defaultColor,
                          child: IconButton(
                              onPressed: () {
                                AppCubit.get(context).removePostImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16.0,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          AppCubit.get(context).pickPostImage();
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.image),
                            SizedBox(width: 5),
                            Text('Add Photo')
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: (){},
                        child: const Text('# tags')
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
