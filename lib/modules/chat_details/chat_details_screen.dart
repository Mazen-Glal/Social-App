import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/create_user_model/create_user_model.dart';
import 'package:social_app/models/message_model/message_model.dart';
import 'package:social_app/shared/styles/colors.dart';
class ChatDetailsScreen extends StatelessWidget {
  CreateUserModel? model;
  ChatDetailsScreen({super.key, this.model});
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(model != null)
        {
          AppCubit.get(context).getMessages(receiverId: model!.uId);
          debugPrint('length of messages list is  ${AppCubit.get(context).messages?.length.toString()}');
        }else{
          debugPrint('the model is null');
        }
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(model?.image??''),
                ),
                const SizedBox(width: 15),
                Text(model?.name??'No one',style:const  TextStyle(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:   [
                if(AppCubit.get(context).messages!.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if(AppCubit.get(context).messages![index].receiverId == model!.uId)
                        {
                          return receiverMessage(AppCubit.get(context).messages![index]);
                        }else{
                          return senderMessage(AppCubit.get(context).messages![index]);
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(height:15),
                      itemCount: AppCubit.get(context).messages!.length,
                    ),
                  ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          onFieldSubmitted: (value){},
                          controller: textController,
                          validator: (value) {
                            if(value!.isEmpty) {
                              return 'message must not be empty';
                            } else {
                              return null;
                            }
                          },
                          decoration:const InputDecoration(
                              hintText: 'type your message...',
                              prefixIcon: Icon(Icons.text_fields),
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        child: const Icon(Icons.send,color: Colors.white),
                        onPressed:() {
                          AppCubit.get(context).sendMessage(
                              receiverId: model?.uId??'',
                              dateTime: TimeOfDay.now().format(context),
                              text: textController.text
                          ).then((value){
                            textController.text = '';
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget senderMessage(MessageModel? model)
  {
    return Align(
        alignment: Alignment.topRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: defaultColor
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${model!.text}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                )
            ),
            Text('${model.dateTime}',style:const TextStyle(fontSize: 12,color: Colors.grey,))
          ],
        )
    );
  }
  Widget receiverMessage(MessageModel? model)
  {
    return Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${model!.text}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                )
            ),
            Text('${model.dateTime}',style:const  TextStyle(fontSize: 12,color: Colors.grey,))
          ],
        )
    );
  }
}
