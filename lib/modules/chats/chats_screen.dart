import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/create_user_model/create_user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/styles/colors.dart';
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatItem(context,AppCubit.get(context).allUsers![index]),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: AppCubit.get(context).allUsers?.length??0
          ),
        );
      },
    );
  }

  Widget buildChatItem(context,CreateUserModel? model)
  {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(model: model)));
      },
      child: Row(
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
    );
  }
}
