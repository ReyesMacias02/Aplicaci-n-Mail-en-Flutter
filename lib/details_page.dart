import 'package:flutter/material.dart';
import 'package:rest_api_app/models/email.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.userPet});
  final Email userPet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Correo ${userPet.id}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(height: 10),
                Text(
                  "Tema: ${userPet.subject} ",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "From: ${userPet.from} ",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  userPet.body,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  "",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "Fecha: ${userPet.dateTime} ",
                  textAlign: TextAlign.justify,
                  style:
                      const TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      userPet.read ? Icons.email : Icons.email,
                      color: userPet.read ? Colors.green : Colors.red,
                    ),
                    Text(
                      userPet.read
                          ? 'Mensaje leido.'
                          : 'Mensaje no ha sido leido',
                      style: TextStyle(
                        fontSize: 22,
                        color: userPet.read ? Colors.green : Colors.red,
                      ),
                    ),
                    Text(
                      "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
