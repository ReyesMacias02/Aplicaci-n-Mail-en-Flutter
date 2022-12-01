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
  bool isDataLoaded = false;
  // error holding
  String errorMessage = '';

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

  refresh() {
    setState(() {});
  }

  Widget getRow(
    int index,
  ) {
    return Card(
        // Then show a snackbar.
        child: Dismissible(
      direction: DismissDirection.horizontal,
      key: Key('item ${usersPets[index].id}'),
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.down) {
          print("Add to favorite");
        } else {
          print('Remove item');
        }

        setState(() {
          Backend().deleteEmail(usersPets[index].id);
        });
      },
      child: ListTile(
        onTap: () {
          // Navigate to Next Details
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(userPet: usersPets[index]),
              ));
        },
        onLongPress: () {
          Backend().markEmailAsRead(usersPets[index].id);
          print('actualizado');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Correo Marcado como leido')));
          refresh();
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              usersPets[index].dateTime.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              usersPets[index].subject,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('De: ${usersPets[index].from}'),
          ],
        ),
        trailing: Icon(
          usersPets[index].read ? Icons.email : Icons.email,
          color: usersPets[index].read ? Colors.green : Colors.red,
        ),
      ),
    ));
  }
}
