import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskbuddy/widgets/task_cards.dart';
import 'package:taskbuddy/repository/task_model.dart';

class FinishedTasks extends StatefulWidget {
  const FinishedTasks({super.key});

  @override
  State<FinishedTasks> createState() => _FinishedTasksState();
}

class _FinishedTasksState extends State<FinishedTasks> {
  Box<TaskModel> taskBox = Hive.box('tasks');
  Box<TaskModel> completedBox = Hive.box('completedTasks');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: ListView.builder(
        itemCount: completedBox.length,
        itemBuilder: (context, index) {
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
                            task: completedBox.values.elementAt(index),
                            isFinished: true,
                          ),
                        );
                      },
                    );
                    setState(() {});
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
                            showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: const Text(
                                      'You sure you didn\'t complete the task already?'),
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
                                        var boxItem = completedBox.values
                                            .elementAt(index);
                                        Navigator.pop(context);
                                        completedBox.deleteAt(index);
                                        setState(() {});
                                        taskBox.put(
                                          boxItem.title,
                                          TaskModel(
                                            dateTime: boxItem.dateTime,
                                            isCompleted: false,
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
                          },
                          icon: const Icon(
                            Icons.thumb_up_rounded,
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
                                    completedBox.values.elementAt(index).title,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color:
                                            CupertinoColors.darkBackgroundGray,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    completedBox.values
                                        .elementAt(index)
                                        .description,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.darkBackgroundGray,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              Text(
                                completedBox.values
                                    .elementAt(index)
                                    .finishedTime,
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
                            completedBox.deleteAt(index);
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
