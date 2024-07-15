import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskbuddy/setup_screen.dart';
import 'package:taskbuddy/task_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Box<TaskModel> taskBox = await Hive.openBox('tasks');
  if (taskBox.isEmpty) {
    taskBox.add(
      TaskModel(
        dateTime: DateTime.now(),
        isCompleted: false,
        title: 'Test',
        description: 'Test Task',
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: SetUpScreen(),
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'SFPro',
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
