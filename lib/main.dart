import 'package:flutter/material.dart';
import 'my_app.dart';
import 'injection.dart' as IC;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IC.init();
  runApp(const MyApp());
}
