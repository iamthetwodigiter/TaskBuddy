import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskbuddy/task_model.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selected = 0;
  Box<TaskModel> taskBox = Hive.box('tasks');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: CupertinoColors.lightBackgroundGray,
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 50,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'TaskBuddy',
                            style: TextStyle(
                                fontSize: 20, color: CupertinoColors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.425,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: CupertinoColors.lightBackgroundGray,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              padding: const EdgeInsets.all(10),
                              highlightColor: CupertinoColors.separator,
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.search,
                                color: CupertinoColors.black,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: CupertinoColors.lightBackgroundGray,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              padding: const EdgeInsets.all(10),
                              highlightColor: CupertinoColors.separator,
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.bell,
                                color: CupertinoColors.black,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/man.png',
                            height: 55,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Have a Good Day,',
                      style: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 45,
                      ),
                    ),
                    const Text(
                      'Prabhat 👋🏻',
                      style: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width / 1.38,
                          child: CupertinoTextField(
                            style: const TextStyle(
                              color: CupertinoColors.black,
                              fontSize: 25,
                            ),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                width: 0.5,
                                color: CupertinoColors.separator,
                              ),
                            ),
                            placeholder: 'I want to...',
                            placeholderStyle: const TextStyle(
                                fontSize: 20, color: CupertinoColors.separator),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CupertinoButton(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.deepOrange,
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/send.png',
                            color: CupertinoColors.white,
                            height: 35,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            color: selected == 0
                                ? Colors.deepOrange
                                : CupertinoColors.separator,
                            borderRadius: BorderRadius.circular(50),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            onPressed: () {
                              setState(() {
                                selected = 0;
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(CupertinoIcons.bell),
                                Text('Now'),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            color: selected == 1
                                ? Colors.deepOrange
                                : CupertinoColors.separator,
                            borderRadius: BorderRadius.circular(50),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            onPressed: () {
                              setState(() {
                                selected = 1;
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(CupertinoIcons.clock),
                                Text('Tomorrow'),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            color: selected == 2
                                ? Colors.deepOrange
                                : CupertinoColors.separator,
                            borderRadius: BorderRadius.circular(50),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            onPressed: () {
                              setState(() {
                                selected = 2;
                              });
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(CupertinoIcons.calendar),
                                Text('Next Week'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: size.width * 0.95,
                      child: ListView.builder(
                          itemCount: taskBox.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: size.width * 0.5,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: CupertinoColors.separator,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        taskBox.values.elementAt(index).title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                      Text(
                                        taskBox.values
                                            .elementAt(index)
                                            .description,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    DateFormat.yMMMMEEEEd().format(
                                      taskBox.values.elementAt(index).dateTime,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
