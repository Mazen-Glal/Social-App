import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            TextButton(
                child: const Text('UPDATE'),
                onPressed: () async {

                  if(profileImage != null){
                    await AppCubit.get(context).updateUserProfile();
                  }

                  if(coverImage != null){
                      await AppCubit.get(context).updateUserCover();
                  }

                  AppCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text
                  );
                }),
            const SizedBox(width: 5),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is UserUpdateProfileLoadingState || state is UserUpdateCoverLoadingState || state is UserUpdateDataLoadingState)
                  const LinearProgressIndicator(),
                if(state is UserUpdateProfileLoadingState || state is UserUpdateCoverLoadingState || state is UserUpdateDataLoadingState)
                  const SizedBox(height: 10.0),
                SizedBox(
                  height: 195,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  image: DecorationImage(
                                      image: coverImage != null
                                          ? FileImage(coverImage)
                                          : NetworkImage('${userModel.cover}')
                                              as ImageProvider,
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 16.0,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).pickCoverImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                      size: 16.0,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 59,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                                radius: 55,
                                backgroundImage: profileImage != null
                                    ? FileImage(profileImage)
                                    : NetworkImage('${userModel.image}')
                                        as ImageProvider),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              radius: 16.0,
                              backgroundColor: defaultColor,
                              child: IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).pickProfileImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 16.0,
                                  )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.name,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name must be not empty';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  controller: nameController,
                  decoration: const InputDecoration(
                      label: Text('name...'),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'bio must be not empty';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  controller: bioController,
                  decoration: const InputDecoration(
                      label: Text('bio...'),
                      prefixIcon: Icon(Icons.text_fields),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'phone must be not empty';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  controller: phoneController,
                  decoration: const InputDecoration(
                      label: Text('phone'),
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
