import 'package:flutter/material.dart';
import 'package:han_nom_tu_dien/SQLHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!await SQLHelper.existsDb(await getDatabasesPath())){
    print("no DB");
    SQLHelper.create();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hán Nôm tự điển',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
          colorScheme:const ColorScheme.light(
            secondary: Colors.white
          )
      ),
      home: const Home(),
    );
  }
}




