import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

  Color backgroundColor = Colors.white;
  int backgroundColorIndex = 0;

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
    getBackgroundPreference().then(_updateBackground);

    // prefix: 'audio/',
    // fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    // 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
  }

  void _updateName(String value) {
    setState(() {
      initialText = value;
      _editingController = TextEditingController(text: value);
    });

    print("Name is this: " + initialText);
  }

  void _updateBackground(int value) {
    setState(() {
      backgroundColor = Color(value);
    });

    print("Background is this: " + backgroundColor.toString());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color pickerColor = backgroundColor;

    return Scaffold(
        // resizeToAvoidBottomInset : false,
        backgroundColor: backgroundColor,
        body: Container(
            padding: EdgeInsets.all(10),
            // alignment: Alignment.center,
            child: Column(children: [
              Expanded(
                flex: 95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: Image(image: AssetImage('assets/' + catImg), width: 128, height: 128, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 20),
                    _editTitleTextField(),
                    const SizedBox(height: 20),
                    buildOutlinedButton("f e e d", Icons.cake, Colors.pinkAccent[100]!, 'catFull', 'eating.mp3'),
                    const SizedBox(height: 5),
                    buildOutlinedButton("p e t", Icons.pets, Colors.purpleAccent[100]!, 'catHappy', 'meow.mp3'),
                    const SizedBox(height: 5),
                    buildOutlinedButton("s l e e p", Icons.bedtime, Colors.blueAccent[100]!, 'catSleep', 'click.mp3'),
                    const SizedBox(height: 5),
                    buildOutlinedButton("w a l k", Icons.directions_walk, Colors.greenAccent[100]!, 'catPlay', 'itemGet.wav'),
                  ],
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Row(children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
                                  height: 150,
                                  color: Colors.amber[200],
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(
                                      "settings",
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber[800]),
                                    ),
                                    const SizedBox(height: 5),
                                    Divider(
                                      height: 5,
                                      thickness: 1,
                                      color: Colors.amber[800],
                                      // endIndent: 230,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          OutlinedButton(
                                              child: const Text('change background', style: TextStyle(color: Colors.brown),),
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(color: Colors.brown),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        actionsPadding: EdgeInsets.all(20),
                                                        title: Text('pick color!'),
                                                        content: SingleChildScrollView(
                                                          child: ColorPicker(
                                                            pickerColor: pickerColor, //default color
                                                            onColorChanged: (Color color) {
                                                              //on color picked
                                                              setState(() {
                                                                pickerColor = color;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          OutlinedButton(
                                                            child: const Text('DONE'),
                                                            onPressed: () {
                                                              setState(() {
                                                                backgroundColor = pickerColor;
                                                                setBackgroundColor(pickerColor);//dismiss the color picker
                                                              });
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              })
                                        ])
                                  ]));
                            });
                      },
                      icon: Icon(Icons.star),
                    )
                  ]))
            ])));
  }

  Widget buildOutlinedButton(String message, IconData icon, Color color, String catEmotion, String soundEffect) {
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
            fixedSize: MaterialStateProperty.all(Size.fromWidth(120)), foregroundColor: MaterialStateProperty.all<Color>(Colors.white), backgroundColor: MaterialStateProperty.all<Color>(color)));
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      return Container(
        width: 100,
        child: TextField(
          style: TextStyle(fontFamily: 'Courier'),
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
          style: TextStyle(color: Colors.black, fontSize: 18.0, fontFamily: 'Courier'),
        ));
  }

  void setName(String name) {
    saveNamePreference(name).then((bool committed) {
      //do something here
      print("Name has been saved to: " + name);
    });
  }
  void setBackgroundColor(Color color) {
    saveBackgroundPreference(color).then((bool committed) {
      //do something here
      print("Background Color has been saved to: " + color.toString());
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

  Future<bool> saveBackgroundPreference(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('backgroundColor', color.value);
  }

  Future<int> getBackgroundPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('backgroundColor') ?? Colors.white.value;
  }

  void bottomBar() {
    // showModalBottomSheet(context: context, builder: builder);
    // return Drawer(
    //   // Add a ListView to the drawer. This ensures the user can scroll
    //   // through the options in the drawer if there isn't enough vertical
    //   // space to fit everything.
    //   child: ListView(
    //     // Important: Remove any padding from the ListView.
    //     padding: EdgeInsets.zero,
    //     children: [
    //       const DrawerHeader(
    //         decoration: BoxDecoration(
    //           color: Colors.blue,
    //         ),
    //         child: Text('Drawer Header'),
    //       ),
    //       ListTile(
    //         title: const Text('Item 1'),
    //         onTap: () {
    //           // Update the state of the app
    //           // ...
    //           // Then close the drawer
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('Item 2'),
    //         onTap: () {
    //           // Update the state of the app
    //           // ...
    //           // Then close the drawer
    //           Navigator.pop(context);
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }



  // getName()
}
