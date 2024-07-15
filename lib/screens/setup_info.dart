import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskbuddy/screens/landing_screen.dart';

class SetupInfo extends StatefulWidget {
  const SetupInfo({super.key});

  @override
  State<SetupInfo> createState() => _SetupInfoState();
}

class _SetupInfoState extends State<SetupInfo> {
  late TextEditingController _nameController;
  Box user = Hive.box('user');
  bool man = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/logo.png'),
                const Spacer(),
                const Text(
                  'TELL ME ABOUT YOURSELF 😀',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    padding: const EdgeInsets.all(10),
                    style: const TextStyle(color: Colors.deepOrange, fontSize: 20),
                    controller: _nameController,
                    placeholder: 'Enter your name',
                    placeholderStyle: const TextStyle(fontSize: 20, color: CupertinoColors.opaqueSeparator),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.separator,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Choose your gender',
                  style: TextStyle(color: Colors.deepOrange,fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          man = true;
                        });
                      },
                      child: man
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/man.png',
                                  height: 60,
                                ),
                                const Icon(
                                  Icons.done_rounded,
                                  color: CupertinoColors.white,
                                  size: 50,
                                ),
                              ],
                            )
                          : Image.asset(
                              'assets/images/man.png',
                              height: 60,
                            ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          man = false;
                        });
                      },
                      child: !man
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/woman.png',
                                  height: 60,
                                ),
                                const Icon(
                                  Icons.done_rounded,
                                  color: CupertinoColors.white,
                                  size: 50,
                                ),
                              ],
                            )
                          : Image.asset(
                              'assets/images/woman.png',
                              height: 60,
                            ),
                    ),
                  ],
                ),
                CupertinoButton(
                  color: Colors.deepOrange,
                  child: const Text('Finish', style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    user.put('name', _nameController.text.trimRight());
                    user.put('gender', man ? 'male' : 'female');
                    user.put('setup', false);
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const LandingScreen(),
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
