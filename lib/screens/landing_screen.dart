import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskbuddy/widgets/finished_tasks.dart';
import 'package:taskbuddy/screens/search_tasks.dart';
import 'package:taskbuddy/repository/task_model.dart';
import 'package:taskbuddy/widgets/unfinished_tasks.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selected = 0;
  Box<TaskModel> taskBox = Hive.box('tasks');
  Box user = Hive.box('user');

  final TextEditingController _titleContoller = TextEditingController();
  final TextEditingController _descriptionContoller = TextEditingController();
  final PageController _pageController = PageController();

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
                              fontSize: 20,
                              color: CupertinoColors.black,
                            ),
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
                              onPressed: () {
                                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const SearchScreen()));
                              },
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
                            user.get('gender') == 'male'
                                ? 'assets/images/man.png'
                                : 'assets/images/woman.png',
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
                    Text(
                      '${user.get('name')} 👋🏻',
                      style: const TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CupertinoButton(
                      color: Colors.deepOrange,
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text('Add Task'),
                              content: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  CupertinoTextField(
                                    controller: _titleContoller,
                                    placeholder: 'Task Title',
                                    style: const TextStyle(
                                      color: CupertinoColors.darkBackgroundGray,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CupertinoTextField(
                                    controller: _descriptionContoller,
                                    placeholder: 'Task Description',
                                    style: const TextStyle(
                                      color: CupertinoColors.darkBackgroundGray,
                                    ),
                                    maxLines: 6,
                                  ),
                                ],
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: CupertinoColors.destructiveRed),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text('Create'),
                                  onPressed: () {
                                    if (_titleContoller.text == '') {
                                      Navigator.pop(context);
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: const Text(
                                                  'Task Title cannot be empty!!'),
                                              actions: [
                                                CupertinoDialogAction(
                                                  isDestructiveAction: true,
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    } else {
                                      Navigator.pop(context);
                                      taskBox.put(
                                        _titleContoller.text,
                                        TaskModel(
                                          dateTime: DateFormat.yMMMd()
                                              .format(DateTime.now()),
                                          isCompleted: false,
                                          title: _titleContoller.text,
                                          description:
                                              _descriptionContoller.text,
                                        ),
                                      );
                                      _titleContoller.clear();
                                      _descriptionContoller.clear();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Add a Task',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CupertinoButton(
                            color: selected == 0
                                ? Colors.deepOrange
                                : CupertinoColors.lightBackgroundGray,
                            borderRadius: BorderRadius.circular(50),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            onPressed: () {
                              setState(() {
                                selected = 0;
                              });
                              _pageController.jumpToPage(selected);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.notification_important_rounded,
                                  color: selected == 1
                                      ? Colors.deepOrange
                                      : CupertinoColors.white,
                                ),
                                Text(
                                  'Unfinished',
                                  style: TextStyle(
                                    color: selected == 1
                                        ? Colors.deepOrange
                                        : CupertinoColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            color: selected == 1
                                ? Colors.deepOrange
                                : CupertinoColors.lightBackgroundGray,
                            borderRadius: BorderRadius.circular(50),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            onPressed: () {
                              setState(() {
                                selected = 1;
                              });
                              _pageController.jumpToPage(selected);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up_rounded,
                                  color: selected == 0
                                      ? Colors.deepOrange
                                      : CupertinoColors.white,
                                ),
                                Text(
                                  'Finished',
                                  style: TextStyle(
                                    color: selected == 0
                                        ? Colors.deepOrange
                                        : CupertinoColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: size.height * 0.525,
                      child: PageView(
                        controller: _pageController,
                        children: const [
                          UnfinishedTasks(),
                          FinishedTasks(),
                        ],
                        onPageChanged: (value) {
                          setState(() {
                            selected = value;
                          });
                        },
                      ),
                    ),
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
