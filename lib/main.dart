import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'modules/login/cubit/bloc_odserve.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initialObject();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  late Widget widget ;
  uId = CacheHelper.getData("UId");
  if(uId == null)
  {
    widget = LoginScreen();
  }
  else
  {
    widget = const SocialLayout();
  }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget,
      ),
    );
  }
}

