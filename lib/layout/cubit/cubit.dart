import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/create_user_model/create_user_model.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_posts/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  var picker = ImagePicker();

  // profile image settings
  File? profileImage;
  Future<void> pickProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccess());
    } else {
      debugPrint('no image selected..');
      emit(ProfileImagePickedError());
    }
  }

  String? profileImageURL;
  Future<void> uploadProfileImage() async {
    emit(UploadProfilePickedLoading());
    firebase_storage.FirebaseStorage.instance
        // upload image on firebase_Storage
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
          //get link to set it on firebaseFirestore
       p0.ref.getDownloadURL().then((value) {
        debugPrint(value);
        profileImageURL = value;
        emit(UploadProfilePickedSuccess());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(UploadProfilePickedError());
      });
    }).catchError((error) {
      emit(UploadProfilePickedError());
    });
  }
  Future<void> updateUserProfile() async {
    emit(UserUpdateProfileLoadingState());
      await uploadProfileImage().then((value) {
        if(profileImageURL != null)
        {
          CreateUserModel model = CreateUserModel(
              name: userModel!.name,
              phone: userModel!.phone,
              bio: userModel!.bio,
              image: profileImageURL,
              email: userModel!.email,
              uId: userModel!.uId,
              cover: userModel!.cover,
              isVerified: userModel!.isVerified
          );
          FirebaseFirestore.instance
              .collection('users')
              .doc(userModel!.uId)
              .update(model.toMap())
              .then((value)
          {
            getUserData();
          }).catchError((error) {
            emit(UserUpdateProfileErrorState());
          });

        }
      });
  }


  // cover image settings
  File? coverImage;
  Future<void> pickCoverImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverPickedSuccess());
    } else {
      debugPrint('no image selected..');
      emit(CoverPickedError());
    }
  }

  String? coverImageURL;
  Future<void> uploadCoverImage() async{
    emit(UploadCoverPickedLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((p0){
          p0.ref.getDownloadURL().then((value) {
        debugPrint(value);
        coverImageURL = value;
        emit(UploadCoverPickedSuccess());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(UploadCoverPickedError());
      });
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UploadCoverPickedError());
    });
  }
  Future<void> updateUserCover() async {
    emit(UserUpdateCoverLoadingState());
      await uploadCoverImage().then((value) {
        if(coverImageURL != null)
        {
          CreateUserModel model = CreateUserModel(
              name: userModel!.name,
              phone: userModel!.phone,
              bio: userModel!.bio,
              image: userModel!.image,
              email: userModel!.email,
              uId: userModel!.uId,
              cover: coverImageURL,
              isVerified: userModel!.isVerified
          );
          FirebaseFirestore.instance
              .collection('users')
              .doc(userModel!.uId)
              .update(model.toMap())
              .then((value)
          {
            getUserData();
          }).catchError((error) {
            emit(UserUpdateCoverErrorState());
          });

        }
      });

  }


  List<String> titles = [
    'Home',
    'Chats',
    'New Posts',
    'Users',
    'Settings',
  ];
  List<Widget> screens =  [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];


  late CreateUserModel? userModel;
  Future<void> getUserData() async {
    await FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      debugPrint(value.data().toString());
      userModel = CreateUserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio
  }) {
    emit(UserUpdateDataLoadingState());
    CreateUserModel model = CreateUserModel(
        name: name,
        phone: phone,
        bio: bio,
        image: userModel!.image,
        email: userModel!.email,
        uId: userModel!.uId,
        cover: userModel!.cover,
        isVerified: userModel!.isVerified
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value){
      getUserData();
    }).catchError((error) {
      emit(UserUpdateDataErrorState());
    });

  }

  int currentIndex = 0;
  void changeBottomNavItem(int index) {
    if(index == 1){
      getAllUsers();
    }
    if (index == 2) {
      emit(ChangeBottomNavBarToNewPost());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBar());
    }
  }

  // create post
  File? postImage;
  Future<void> pickPostImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccess());
    } else {
      debugPrint('no image selected..');
      emit(PostImagePickedError());
    }
  }
  void removePostImage()
  {
    postImage = null;
    emit(RemovePostImageState());
  }

  void createPostWithoutImage({
    required String dateTime,
    required String text,
    String? postImage
  }) {
    emit(LoadingCreatePostState());
    PostModel model = PostModel(
        name: userModel!.name,
        text: text,
        dateTime: dateTime,
        image: userModel!.image,
        uId: userModel!.uId,
        postImage: postImage??'',
        likes: 0
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
          emit(SuccessCreatePostState());
          getAllPosts();
    }).catchError((error) {
      emit(ErrorCreatePostState());
    });
  }

  Future<void> createPostWithImage({
    required String dateTime,
    required String text,
  }) async {
    emit(UploadPostImagePickedLoading());
    firebase_storage.FirebaseStorage.instance
    // upload image on firebase_Storage
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((p0) {
      //get link to set it on firebaseFirestore
      p0.ref.getDownloadURL().then((value) {
        debugPrint(value);
        emit(UploadPostImagePickedSuccess());
        createPostWithoutImage(dateTime: dateTime, text: text,postImage: value);
      }).catchError((error) {
        debugPrint(error.toString());
        emit(UploadPostImagePickedError());

      });
    }).catchError((error) {
      emit(UploadPostImagePickedError());
    });
  }

  //get All posts
  List<PostModel>? posts ;
  List<String>? postIds;
  Future<void> getAllPosts() async {
    emit(GetPostsLoadingState());
    await FirebaseFirestore.instance.collection('posts').get().then((value) {

      // get the all posts in my hand
      posts = value.docs.map((e) => PostModel.fromJson(e.data())).toList();
      // postIds --> used in likePost to specify which post liked.
      postIds =value.docs.map((e) => e.id).toList();

      debugPrint('the length of list is ${posts!.length}');
      debugPrint(posts.toString());
      emit(GetPostsSuccessState());
    }).catchError((error) {
      debugPrint('the error is ${error.toString()}');
      emit(GetPostsErrorState(error.toString()));
    });

  }
  void likePost(String postId)
  {
    emit(LikePostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'likes':true})
        .then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .get().then((value) {
            var likedPostModel = PostModel(
              postImage: value.data()!['postImage'],
              name: value.data()!['name'],
              uId: value.data()!['uId'],
              image: value.data()!['image'],
              likes: value.data()!['likes']+=1,
              dateTime: value.data()!['dateTime'],
              text: value.data()!['text'],
            );
            FirebaseFirestore.instance
                .collection('posts')
                .doc(postId)
                .update(likedPostModel.toMap()).then((value) {
                  emit(CountLikePostsSuccessState());
            }).catchError((error){
              emit(CountLikePostsErrorState(error));
            });

      });
          emit(LikePostsSuccessState());
        })
        .catchError((error){emit(LikePostsErrorState(error.toString()));});
  }

  List<CreateUserModel>? allUsers;
  Future<void> getAllUsers() async {
      allUsers = [];
      emit(GetAllUserLoadingState());
      await FirebaseFirestore.instance.collection('users').get().then((value) {

        allUsers = value.docs.map((e) => CreateUserModel.fromJson(e.data())).toList();
        // not chat with my self
        // for(int i=0;i<allUsers!.length;i++ )
        // {
        //   if(allUsers![i].uId == userModel!.uId) {
        //     allUsers!.remove(allUsers![i]);
        //   }
        // }
        emit(GetAllUserSuccessState());
      }).catchError((error) {
        debugPrint('the error is ${error.toString()}');
        emit(GetAllUserErrorState(error.toString()));
      });

  }

  Future<void> sendMessage({
    required String? receiverId,
    required String? dateTime,
    required String? text,
  })async {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel!.uId
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
          emit(SendMessageSuccessState());
    })
        .catchError((error){
          emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });
  }

  //get All messages
  List<MessageModel>? messages;
  void getMessages({required String? receiverId})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          debugPrint(messages?.length.toString());
          messages = event.docs.map((e) => MessageModel.fromJson(e.data())).toList();
          debugPrint(messages?.length.toString());
          emit(GetAllMessageSuccessState());
    });
    // what the difference between get && snapshots
  //   .get()
  //   .then((value) {
          // messages = [];
          // debugPrint(messages?.length.toString());
          // messages = value.docs.map((e) => MessageModel.fromJson(e.data())).toList();
          // debugPrint(messages?.length.toString());
          // emit(GetAllMessageSuccessState());
          // }).catchError((error){
          //
  // });

  }
}
