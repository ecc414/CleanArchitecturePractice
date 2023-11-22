import 'package:clearn_architecture_practice/di/provider_setup.dart';
import 'package:clearn_architecture_practice/domain/use_case/lock_orientation_use_case.dart';
import 'package:clearn_architecture_practice/presentation/home/home_screen.dart';
import 'package:clearn_architecture_practice/util/color_schemes.g.dart';
import 'package:clearn_architecture_practice/util/orientation_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: globalProviders, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LockOrientationUseCase().execute(OrientationMode.portraitOnly);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const HomeScreen(),
    );
  }
}
