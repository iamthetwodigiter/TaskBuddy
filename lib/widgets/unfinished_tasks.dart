import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:taskbuddy/widgets/task_cards.dart';
import 'package:taskbuddy/repository/task_model.dart';

class UnfinishedTasks extends StatefulWidget {
  const UnfinishedTasks({super.key});

  @override
  State<UnfinishedTasks> createState() => _UnfinishedTasksState();
}

class _UnfinishedTasksState extends State<UnfinishedTasks> {
  Box<TaskModel> taskBox = Hive.box('tasks');
  Box<TaskModel> completedBox = Hive.box('completedTasks');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: ListView.builder(
        itemCount: taskBox.length,
        itemBuilder: (context, index) {
          bool istaskCompleted = taskBox.values.elementAt(index).isCompleted;
          return TextButton(
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero)),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    color: Colors.deepOrangeAccent.withOpacity(0.2),
                    height: size.height * 0.6,
                    width: size.width - 20,
                    child: TaskCards(
                      task: taskBox.values.elementAt(index),
                    ),
                  );
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: size.width * 0.225,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.withOpacity(0.2),
                border: Border.all(
                  color: CupertinoColors.separator,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      var boxItem = taskBox.values.elementAt(index);

                      setState(() {
                        istaskCompleted = !istaskCompleted;
                      });

                      if (completedBox.containsKey(boxItem.title)) {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text(
                                  'Task with same title exists\nOverwrite the existing task?'),
                              actions: [
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    taskBox.deleteAt(index);
                                    setState(() {});
                                    completedBox.put(
                                      boxItem.title,
                                      TaskModel(
                                        dateTime: boxItem.dateTime,
                                        finishedTime: DateFormat.yMMMd()
                                            .add_Hms()
                                            .format(DateTime.now()),
                                        isCompleted: true,
                                        title: boxItem.title,
                                        description: boxItem.description,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        taskBox.deleteAt(index);
                        setState(() {});
                        completedBox.put(
                          boxItem.title,
                          TaskModel(
                            dateTime: boxItem.dateTime,
                            finishedTime: DateFormat.yMMMd()
                                .add_Hms()
                                .format(DateTime.now()),
                            isCompleted: true,
                            title: boxItem.title,
                            description: boxItem.description,
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      istaskCompleted
                          ? Icons.thumb_up_rounded
                          : Icons.thumb_up_outlined,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Container(
                    width: size.width * 0.5,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              taskBox.values.elementAt(index).title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: CupertinoColors.darkBackgroundGray,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              taskBox.values.elementAt(index).description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: CupertinoColors.darkBackgroundGray,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Text(
                          taskBox.values.elementAt(index).dateTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      taskBox.deleteAt(index);
                      setState(() {});
                    },
                    icon: const Icon(
                      CupertinoIcons.delete_solid,
                      color: CupertinoColors.destructiveRed,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
