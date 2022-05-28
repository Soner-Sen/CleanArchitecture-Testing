import 'package:firstcleanarchi/application/advicer/advicer_bloc.dart';
import 'package:firstcleanarchi/presentation/advicer/advicer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart' as IC;
import 'injection.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: BlocProvider(
          create: (context) => sl<AdvicerBloc>(), child: AdvicerPage()),
    );
  }
}
