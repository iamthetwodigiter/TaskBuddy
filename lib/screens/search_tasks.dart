import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskbuddy/widgets/task_cards.dart';
import 'package:taskbuddy/repository/task_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Box<TaskModel>? _tasksBox;
  List<TaskModel> _filteredTasks = [];

  @override
  void initState() {
    super.initState();
    _tasksBox = Hive.box<TaskModel>('tasks');
    _filteredTasks = [];
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    filterResults();
  }

  void filterResults() {
    List<TaskModel> results = [];
    if (_searchController.text.isEmpty) {
      results = [];
    } else {
      results = _tasksBox!.values
          .where((task) => task.title
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredTasks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text('Search'),
      // ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      style: const TextStyle(color: CupertinoColors.darkBackgroundGray),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CupertinoColors.separator, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      controller: _searchController,
                      placeholder: 'Search your tasks',
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(10),
                    highlightColor: CupertinoColors.separator,
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.search,
                      color: CupertinoColors.darkBackgroundGray,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTasks.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color:
                                      Colors.deepOrangeAccent.withOpacity(0.2),
                                  height: size.height * 0.6,
                                  width: size.width - 20,
                                  child: TaskCards(
                                    task: _filteredTasks.elementAt(index),
                                  ),
                                );
                              },
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                _filteredTasks[index].title,
                                style: const TextStyle(
                                    color: CupertinoColors.darkBackgroundGray),
                              ),
                              Text(
                                _filteredTasks[index].description,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: CupertinoColors.darkBackgroundGray),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
