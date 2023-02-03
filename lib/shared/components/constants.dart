import 'package:flutter/material.dart';

PreferredSizeWidget defaultAppBar({
  required context,
  required String title,
  List<Widget>? actions
}){
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_left,size: 35,),
    ),
    title: Text(title),
    actions: actions,
  );
}