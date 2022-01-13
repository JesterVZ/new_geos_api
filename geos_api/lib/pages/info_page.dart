import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../info.dart';

class InfoPage extends StatelessWidget{
  InfoPage({Key? key, required this.info}) : super(key: key);
  Info info;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("worker_id: " + info.worker_id.toString()),
            Text("worker_group_id: " + info.worker_group_id.toString()),
            Text("user_business_id: " + info.user_business_id.toString()),
            Text("firstname: " + info.firstname.toString()),
            Text("lastname: " + info.lastname.toString()),
            Text("patronymic: " + info.patronymic.toString()),
            Text("initials: " + info.initials.toString()),
            Text("email: " + info.email.toString()),
            Text("telephone: " + info.telephone.toString()),
            Text("date_added: " + info.date_added.toString()),
            Text("date_modified: " + info.date_modified.toString()),
            Text("post: " + info.post.toString()),
          ],
        ),
      ),
    );
  }

}