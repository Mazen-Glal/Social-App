import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_posts/new_post_screen.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){
            if(state is ChangeBottomNavBarToNewPost)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostsScreen()));
            }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex ],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add),
                  label: 'New Post'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_city),
                  label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavItem(index);
            },
          ),
    ),
    );
  }
}












// ConditionalBuilder(
//               condition: state is GetUserSuccessState,
//               builder: (context) => Column(
//             children: [
//               if(cubit.model.isVerified == false)
//                 Container(
//                   color: Colors.amber,
//                   child: Row(
//                     children: [
//                       const SizedBox(width: 10),
//                       const Icon(Icons.error_outline_outlined),
//                       const SizedBox(width: 10),
//                       const Text('please verify your email'),
//                       const Spacer(),
//                       Expanded(
//                         child: TextButton(
//                             child:const Text('SEND',style: TextStyle(color: Colors.blue)),
//                             onPressed: (){
//                               FirebaseAuth.instance.currentUser!.sendEmailVerification();
//                             }
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//             ],
//           ),
//               fallback: (context) => const Center(child: CircularProgressIndicator()),
//           ),