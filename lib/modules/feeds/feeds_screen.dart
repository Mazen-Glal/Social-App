// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/shared/styles/colors.dart';
class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
          if (state is CountLikePostsSuccessState) {
            AppCubit.get(context).getAllPosts();
          }
      },
      builder:(context, state) {
        return SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                    child:  Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: const [
                        Image(
                          image: NetworkImage('https://img.freepik.com/free-photo/serious-afro-american-woman-points-away-blank-space_273609-45546.jpg?t=st=1673107190~exp=1673107790~hmac=d0011d0bc8ceb145f8d3d87e09f9ad6d99e05827e36dba9d27834808793e9abd'),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with  friends.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) => itemBuilder(context,AppCubit.get(context).posts![index],index),
                    itemCount: AppCubit.get(context).posts?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            );
      }
    );
  }

  Widget itemBuilder(BuildContext context,PostModel? model,index)
  {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.only(right: 13.0,left: 13.0,top: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(model?.image??'https://img.freepik.com/free-photo/serious-afro-american-woman-points-away-blank-space_273609-45546.jpg?t=st=1673107190~exp=1673107790~hmac=d0011d0bc8ceb145f8d3d87e09f9ad6d99e05827e36dba9d27834808793e9abd%27'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:  [
                        Text(model?.name??'no model',style: const TextStyle(fontWeight: FontWeight.w900),),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 15,
                        )
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children:  [
                        Text(DateFormat.yMMMd().format(DateTime.now()),style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(width: 5),
                        Text(TimeOfDay.now().format(context),style: Theme.of(context).textTheme.bodySmall),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz)
              ],
            ),
            const SizedBox(height: 10),
            Text(model?.text??'no text',style: const TextStyle(fontWeight: FontWeight.w500),),
            const SizedBox(height: 10),
            if(model?.postImage != '' )
              Image(image: NetworkImage(model?.postImage??'')),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {

              },
              child: Row(
                children:[
                  const Icon(Icons.favorite_border),
                  const SizedBox(width: 5),
                  Text('${AppCubit.get(context).posts?[index].likes??'${0}'}',style :const TextStyle(color: Colors.grey)),
                  const Spacer(),
                  const Icon(Icons.chat),
                  const SizedBox(width: 5),
                  const Text('654 comments',style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                InkWell(
                  onTap: () {

                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(AppCubit.get(context).userModel?.image??''),
                      ),
                      const SizedBox(width: 10),
                      Text('write a comment..',style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    AppCubit.get(context).likePost(AppCubit.get(context).postIds![index]);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.favorite_border,color: Colors.purpleAccent,size: 20,),
                      const SizedBox(width: 5),
                      Text('Like',style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
