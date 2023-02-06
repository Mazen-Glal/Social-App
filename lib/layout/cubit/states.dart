abstract class AppStates {}

class InitialState extends AppStates{}

class GetUserLoadingState extends AppStates{}
class GetUserSuccessState extends AppStates{}
class GetUserErrorState extends AppStates{
  final String error;
  GetUserErrorState(this.error);
}

// get all users
class GetAllUserLoadingState extends AppStates{}
class GetAllUserSuccessState extends AppStates{}
class GetAllUserErrorState extends AppStates{
  final String error;
  GetAllUserErrorState(this.error);
}

class ChangeBottomNavBar extends AppStates{}
class ChangeBottomNavBarToNewPost extends AppStates{}

class ProfileImagePickedSuccess extends AppStates{}
class ProfileImagePickedError extends AppStates{}

class CoverPickedSuccess extends AppStates{}
class CoverPickedError extends AppStates{}

class UploadProfilePickedSuccess extends AppStates{}
class UploadProfilePickedError extends AppStates{}
class UploadProfilePickedLoading extends AppStates{}

class UploadCoverPickedLoading extends AppStates{}
class UploadCoverPickedSuccess extends AppStates{}
class UploadCoverPickedError extends AppStates{}

class UserUpdateDataErrorState extends AppStates{}
class UserUpdateDataLoadingState extends AppStates{}

class UserUpdateProfileErrorState extends AppStates{}
class UserUpdateProfileLoadingState extends AppStates{}

class UserUpdateCoverErrorState extends AppStates{}
class UserUpdateCoverLoadingState extends AppStates{}

//create post
class LoadingCreatePostState extends AppStates{}
class SuccessCreatePostState extends AppStates{}
class ErrorCreatePostState extends AppStates{}

class PostImagePickedSuccess extends AppStates{}
class PostImagePickedError extends AppStates{}
class RemovePostImageState extends AppStates{}

class UploadPostImagePickedSuccess extends AppStates{}
class UploadPostImagePickedError extends AppStates{}
class UploadPostImagePickedLoading extends AppStates{}

// get Posts
class GetPostsLoadingState extends AppStates{}
class GetPostsSuccessState extends AppStates{}
class GetPostsErrorState extends AppStates{
  final String error;
  GetPostsErrorState(this.error);
}

// like the post
class LikePostsLoadingState extends AppStates{}
class LikePostsSuccessState extends AppStates{}
class LikePostsErrorState extends AppStates{
  final String error;
  LikePostsErrorState(this.error);
}
// increase the counter of likes
class CountLikePostsSuccessState extends AppStates{}
class CountLikePostsErrorState extends AppStates{
  final String error;
  CountLikePostsErrorState(this.error);
}

//send message
class SendMessageSuccessState extends AppStates{}
class SendMessageErrorState extends AppStates{}
//get all messages
class GetAllMessageSuccessState extends AppStates{}
class GetAllMessageErrorState extends AppStates{}