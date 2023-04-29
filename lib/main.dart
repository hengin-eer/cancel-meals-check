import 'package:cancel_meals_check/calendar.dart';
import 'package:cancel_meals_check/menu.dart';
import 'package:cancel_meals_check/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...
void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String nameText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel meals Checker'),
      ),
      body: Container(
        color: Colors.cyan[100],
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                // obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Type any texts..',
                ),
                onChanged: (text) {
                  nameText = text;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // event on click
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarPage(),
                        fullscreenDialog: true,
                      ));
                },
                child: const Text(
                  'Calendar',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // event on click
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuPage(nameText),
                        fullscreenDialog: true,
                      ));
                },
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        width: double.infinity,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.check_outlined,
                  color: Colors.white,
                  size: 32,
                ),
                label: const Text(
                  '欠食',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuPage('From Top'),
                      fullscreenDialog: true,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.fastfood_outlined,
                  color: Colors.white,
                  size: 32,
                ),
                label: const Text(
                  '献立',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.mail_outlined,
                  color: Colors.white,
                  size: 32,
                ),
                label: const Text(
                  '目安箱',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
