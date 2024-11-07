import 'package:flutter/material.dart';
import 'package:stylish_snackbar_project/stylish_snackbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stylish Snackbar'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          // onPressed: () => showSnackbar(context),
          onPressed: () => showStylishSnackBar(
            context: context,
            text:
                'Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World ',
            textStyle: const TextStyle(color: Color.fromARGB(255, 82, 2, 18)),
            animateDuration: const Duration(milliseconds: 300),
            backgroundColor: const Color.fromARGB(255, 60, 241, 238),
            backgroundColorOpacity: .5,
            duration: const Duration(seconds: 3),
            padding: const EdgeInsets.all(20),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.justify,
          ),
          child: Text(
            'Show Snackbar',
            style: TextStyle(color: Colors.red.shade900),
          ),
        ),
      ),
    );
  }
}
