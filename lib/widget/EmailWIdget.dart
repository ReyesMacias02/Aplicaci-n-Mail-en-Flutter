import 'package:flutter/material.dart';
import 'package:rest_api_app/screen/DetailScreen.dart';
import 'package:rest_api_app/models/email.dart';
import 'package:http/http.dart' as http;

import '../models/backend.dart';

class EmailWidget extends StatefulWidget {
  const EmailWidget({Key? key, required this.indexs}) : super(key: key);
  final int indexs;
  @override
  State<EmailWidget> createState() => _EmailWidgetState(indexs);
}

class _EmailWidgetState extends State<EmailWidget> {
  // For holding response as UserPets
  late List<Email> usersPets;
  late int index;
  // for data is loaded flag
  bool isDataLoaded = false;
  // error holding
  String errorMessage = '';

  _EmailWidgetState(int indexs) {
    this.index = indexs;
  }

  callAPIandAssignData() async {
    usersPets = Backend().getEmails();
  }

  @override
  void initState() {
    callAPIandAssignData();
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ;
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
          // Navigate
          //to Next Details
          Backend().markEmailAsRead(usersPets[index].id);
          print('actualizado');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Correo Marcado como leido')));
          refresh();
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
