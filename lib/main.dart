import 'package:flutter/material.dart';

import 'main_initialization.dart';
import 'testing_playground_app.dart';

Future<void> main() async {
  await mainInitialization();
  runApp(const TestingPlaygroundApp());
}
