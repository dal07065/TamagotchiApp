import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'tamagotchiSave.dart';

/*
  To do's
  - make sound effects
  - change background of the app
  - add a hunger meter
 */

class TamagotchiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Tamagotchi());
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Tamagotchi extends StatefulWidget {
  @override
  State<Tamagotchi> createState() => _TamagotchiState();
}

int timer = 0;
String catImg = 'cat.png';


class _TamagotchiState extends State<Tamagotchi> {
  Timer? timer;
  late final AudioCache _audioCache;
  bool _isEditingText = false;
  late TextEditingController _editingController;
  String initialText = 'n y a n';


  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 5),
        (Timer t) => setState(() {
              catImg = 'cat.png';
            }));
    _audioCache = AudioCache();
    getNamePreference().then(_updateName);


    // prefix: 'audio/',
    // fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    // 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
  }

  void _updateName(String value)
  {
    setState(() {
      initialText = value;
      _editingController = TextEditingController(text: value);
    });

    print("Name is this: " + initialText);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _editTitleTextField(),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 2)),
              child: Image(
                  image: AssetImage('assets/' + catImg),
                  width: 128,
                  height: 128,
                  fit: BoxFit.cover),
            ),
            const SizedBox(height: 50),
            buildOutlinedButton("f e e d", Icons.cake, Colors.pinkAccent[100]!,
                'catFull', 'eating.mp3'),
            const SizedBox(height: 5),
            buildOutlinedButton("p e t", Icons.pets, Colors.purpleAccent[100]!,
                'catHappy', 'meow.mp3'),
            const SizedBox(height: 5),
            buildOutlinedButton("s l e e p", Icons.bedtime,
                Colors.blueAccent[100]!, 'catSleep', 'click.mp3'),
            const SizedBox(height: 5),
            buildOutlinedButton("w a l k", Icons.directions_walk,
                Colors.greenAccent[100]!, 'catPlay', 'itemGet.wav')
          ],
        )));

    // TODO: implement build
    throw UnimplementedError();
  }

  Widget buildOutlinedButton(String message, IconData icon, Color color,
      String catEmotion, String soundEffect) {
    return OutlinedButton.icon(
        onPressed: () {
          _audioCache.play('audio/' + soundEffect);
          // Respond to button press
          setState(() {
            catImg = catEmotion + '.png';
          });
        },
        icon: Icon(icon, size: 18),
        label: Text(message),
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size.fromWidth(120)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(color)));
  }

  Widget _editTitleTextField()  {

    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              _isEditingText = false;
              setName(newValue);
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }

  void setName(String name)
  {
    saveNamePreference(name).then((bool committed){
      //do something here
      print("Name has been saved to: " + name);
    });
  }


  Future<bool> saveNamePreference(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('name', name);
  }

  Future<String> getNamePreference() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? 'n y a n';
  }

   // getName()
}
