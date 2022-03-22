// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:demo/demo.dart';
import 'package:demo/profile.dart';
import 'package:demo/tamagotchi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Add these 2 lines
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  // Then call runApp() as normal
  runApp(TamagotchiApp());
}

