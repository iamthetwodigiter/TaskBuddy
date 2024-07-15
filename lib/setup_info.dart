import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetupInfo extends StatefulWidget {
  const SetupInfo({super.key});

  @override
  State<SetupInfo> createState() => _SetupInfoState();
}

class _SetupInfoState extends State<SetupInfo> {
  late TextEditingController _nameController;

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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: SizedBox(
        height: 800,
        width: 400,
        child: Column(
          children: [
            CupertinoTextField(
              controller: _nameController,
              placeholder: 'Enter your name',
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepOrange,
                  width: 0.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
