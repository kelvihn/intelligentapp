import 'package:flutter/material.dart';
import 'package:intelligentapp/models/user_model.dart';
import 'package:intelligentapp/views/constants/widgets/leadingWidget.dart';
import 'package:intelligentapp/views/userData.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UserData(user: user)));
        },
        leading: LeadingWidget(
          height: 50,
          width: 50,
        ),
        title: Text('${user.name}'),
        subtitle: Text('${user.email}'),
      ),
    );
  }
}
