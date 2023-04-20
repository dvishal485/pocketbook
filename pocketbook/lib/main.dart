import 'package:flutter/material.dart';
//import 'package:pocketbook/screens/analysis.dart';
//import 'package:pocketbook/screens/home.dart';
import 'package:pocketbook/screens/login.dart';
import 'package:isar/isar.dart';
import 'package:pocketbook/collections/transaction.dart';

void main() async {
  Isar isar = await Isar.open([TransactionSchema]);

  //trial code to see how database works

  final trytransaction1 = Transaction()
    ..receiver = 'HDFC'
    ..amount = 999
    ..time = '16423';

  isar.writeTxn(() async {
    await isar.transactions.put(trytransaction1);
  });

  
  runApp(MyApp(isar: isar,));
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({super.key, required this.isar});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: LoginScreen(isar: isar,),
    );
  }
}
