import 'package:flutter/material.dart';
import 'package:rest_api_app/screen/DetailScreen.dart';
import 'package:rest_api_app/models/email.dart';
import 'package:http/http.dart' as http;

import '../models/backend.dart';
import '../widget/EmailWIdget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // For holding response as UserPets
  late List<Email> usersPets;
  // for data is loaded flag

  callAPIandAssignData() async {
    usersPets = Backend().getEmails();
  }

  @override
  void initState() {
    callAPIandAssignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Email-Reyes-Macias'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: usersPets.length,
          itemBuilder: (context, index) => EmailWidget(indexs: index),
        ));
  }
}
