import 'package:flutter/material.dart';

import 'demo.dart';

class Profile extends StatefulWidget {
  Profile(this.name);

  final String name;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _logOut() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Profile', style: TextStyle(color: Colors.blueGrey[500])),
            elevation: 5,
            backgroundColor: Colors.blueGrey[100]),
        body: ListView(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 40),
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey[300],
                    border: Border.all(
                      width: 10,
                      color: (Colors.blueGrey[300])!,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: 128,
                height: 200,
                padding:
                    EdgeInsets.only(left: 70, right: 70, top: 10, bottom: 10),
                child: ClipOval(
                    child: Material(
                  color: Colors.transparent,
                  child: Image(
                      image: AssetImage('assets/images/profilepic.png'),
                      width: 128,
                      height: 128,
                      fit: BoxFit.cover),
                )),
              ),
              const SizedBox(height: 20),
              Center(
                  child: Text(widget.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.blueGrey[800]))),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center ,children: [Icon(Icons.audiotrack_outlined, color: Colors.blueGrey[300]),
                  Text('@samanthaJohnson',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey[400]))]),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: _logOut,
                  child: Row(children: [
                    Icon(Icons.assignment_ind_outlined, color: Colors.blueGrey[600]),
                    const SizedBox(width: 10),
                    Text('Account Info', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.w500))
                  ]),
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18)),
                      alignment: Alignment.centerLeft,

                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blueGrey[100]!),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)))),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _logOut,
                  child: Row(children: [
                    Icon(Icons.add_box_outlined, color: Colors.blueGrey[600]),
                    const SizedBox(width: 10),
                    Text('Saved Collections', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.w500))
                  ]),
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18)),
                      alignment: Alignment.centerLeft,
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blueGrey[100]!),
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(20)))),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _logOut,
                  child: Row(children: [
                    Icon(Icons.emoji_emotions_outlined, color: Colors.blueGrey[600]),
                    const SizedBox(width: 10),
                    Text('Friends', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.w500))
                  ]),
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18)),
                      alignment: Alignment.centerLeft,
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blueGrey[100]!),
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(20)))),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _logOut,
                  child: Row(children: [
                    Icon(Icons.settings, color: Colors.blueGrey[600]),
                    const SizedBox(width: 10),
                    Text('Settings', style: TextStyle(color: Colors.blueGrey[600], fontWeight: FontWeight.w500))
                  ]),
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 18)),
                      alignment: Alignment.centerLeft,
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blueGrey[100]!),
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(20)))),
            ]));
  }
}
