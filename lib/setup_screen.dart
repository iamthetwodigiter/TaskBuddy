import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskbuddy/setup_info.dart';

class SetUpScreen extends StatelessWidget {
  const SetUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset('assets/images/logo.png')),
            ),
            const Text(
              'Never forget your tasks now with TaskBuddy',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 2),
            CupertinoButton(
                borderRadius: BorderRadius.circular(50),
                color: Colors.deepOrange,
                alignment: Alignment.bottomCenter,
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (context) => const SetupInfo(),
                    ),
                  );
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
