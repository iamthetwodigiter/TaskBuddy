import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskbuddy/repository/task_model.dart';
import 'package:taskbuddy/screens/landing_screen.dart';

class TaskCards extends StatefulWidget {
  final TaskModel task;
  final bool isFinished;
  const TaskCards({
    super.key,
    required this.task,
    this.isFinished = false,
  });

  @override
  State<TaskCards> createState() => _TaskCardsState();
}

class _TaskCardsState extends State<TaskCards> {
  Box<TaskModel> taskBox = Hive.box('tasks');
  Box<TaskModel> completeBox = Hive.box('completedTasks');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CupertinoPopupSurface(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.75,
                child: Text(
                  widget.task.title,
                  style: const TextStyle(
                    color: CupertinoColors.darkBackgroundGray,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  widget.isFinished
                      ? completeBox.delete(widget.task.title)
                      : taskBox.delete(widget.task.title);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return LandingScreen(
                          page: widget.isFinished ? 1 : 0,
                        );
                      },
                    ),
                  );
                  setState(() {});
                },
                icon: const Icon(
                  CupertinoIcons.delete_solid,
                  color: CupertinoColors.destructiveRed,
                ),
              ),
            ],
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: size.height * 0.375,
            child: SingleChildScrollView(
              child: Text(
                widget.task.description,
                style: const TextStyle(
                    color: CupertinoColors.darkBackgroundGray, fontSize: 16),
              ),
            ),
          ),
          const Divider(),
          Text(
            'Created: ${widget.task.dateTime}',
            style: const TextStyle(
                color: CupertinoColors.darkBackgroundGray, fontSize: 16),
          ),
          widget.isFinished
              ? Text(
                  'Finished: ${widget.task.finishedTime}',
                  style: const TextStyle(
                      color: CupertinoColors.darkBackgroundGray, fontSize: 16),
                )
              : const Text(''),
          const SizedBox(height: 5),
          CupertinoButton(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(50),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
