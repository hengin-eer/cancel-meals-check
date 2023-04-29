import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  MenuPage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu Page'),
        ),
        body: Container(
          color: Colors.cyan[100],
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back')),
              ],
            ),
          ),
        ));
  }
}
