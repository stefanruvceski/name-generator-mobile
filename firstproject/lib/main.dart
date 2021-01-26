// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'RandomWords.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  //build is for describing hoe to display the widget
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Generator',
      home: RandomWords(),
      theme: ThemeData(       
        colorScheme: ColorScheme.dark(),
      ),
    );
  }
}

