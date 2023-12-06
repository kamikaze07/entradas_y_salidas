import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forsis/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:forsis/theme/theme.dart';
import 'package:forsis/models/layout_model.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(
    ChangeNotifierProvider(
      create: (context) => LayoutModel(),
      child: ChangeNotifierProvider(
        create: (context) => ThemeChanger(2),
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
