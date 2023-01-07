import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
   static late SharedPreferences cache ;
   static initialObject() async{
     cache = await SharedPreferences.getInstance();
   }

   static void saveData(String key,dynamic value) {
     if(value is String) {
       cache.setString(key, value).then((value){
         debugPrint("$value is saved..");
       }).catchError((error){
         debugPrint(error.toString());
       });
     } else if(value is int){
       cache.setInt(key, value).then((value){
         debugPrint("$value is saved..");
       }).catchError((error){
         debugPrint(error.toString());
       });
     }else if(value is bool){
       cache.setBool(key, value).then((value){
         debugPrint("$value is saved..");
       }).catchError((error){
         debugPrint(error.toString());
       });
     }else
     {
       cache.setDouble(key, value).then((value){
         debugPrint("$value is saved..");
       }).catchError((error){
         debugPrint(error.toString());
       });
     }
   }


   static dynamic getData(String key) {
     return cache.get(key);
   }

   static Future<bool> removeData(String key) async {
     return await cache.remove(key);
   }
}