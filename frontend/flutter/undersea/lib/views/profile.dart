import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String cityName;
  final String playerName;

  ProfilePage({required this.cityName, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03255F),
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Color(0xFF1C3E76),
      ),
      body: Column(children: [
        Center(
            child: Column(children: [
          Image.asset('assets/buildings/seastar.png'),
          Text(playerName),
          Divider()
        ])),
        Align(
            alignment: Alignment.centerLeft,
            child: Column(children: [
              Row(children: [
                Text('Városom neve'),
                Icon(Icons.mode_edit_outline_outlined)
              ]),
              Text(cityName),
              Divider(),
              TextButton(
                onPressed: () {
                  //logout
                },
                child: Text('Kijelentkezés'),
              ),
              Divider()
            ]))
      ]),
    );
  }
}
