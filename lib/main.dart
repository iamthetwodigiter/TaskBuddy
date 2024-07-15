import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskbuddy/screens/landing_screen.dart';

import 'package:taskbuddy/screens/setup_screen.dart';
import 'package:taskbuddy/repository/task_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Box user = await Hive.openBox('user');
  if (user.isEmpty) {
    user.put('name', 'John Wick');
    user.put('gender', 'male');
    user.put('setup', true);
  }
  await Hive.openBox<TaskModel>('tasks');
  // if (taskBox.isEmpty) {
  //   taskBox.add(
  //     TaskModel(
  //       dateTime: DateFormat.yMMMd().format(DateTime.now()),
  //       isCompleted: false,
  //       title: 'Test',
  //       description: 'Test Task',
  //     ),
  //   );
  // }
  await Hive.openBox<TaskModel>('completedTasks');
  // if (completedBox.isEmpty) {
  //   completedBox.put(
  //     'Demo Finished Task',
  //     TaskModel(
  //       dateTime: DateFormat.yMMMd().format(DateTime.now()),
  //       finishedTime: DateFormat.yMMMd().add_Hms().format(DateTime.now()),
  //       isCompleted: true,
  //       title: 'Demo Finished Task',
  //       description: 'This demo task has been added because you are not yet able to finish one of your own 😐',
  //     ),
  //   );
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Box user = Hive.box('user');
    bool setupNeeded = user.get('setup');
    return CupertinoApp(
      home: setupNeeded ? const SetUpScreen() : const LandingScreen(),
      theme: const CupertinoThemeData(
        scaffoldBackgroundColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'SFPro',
            color: CupertinoColors.black
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
