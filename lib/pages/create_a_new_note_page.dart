import 'package:flutter/material.dart';

class CreateANewNotePage extends StatefulWidget {
  final bool isNewCategory;
  const CreateANewNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateANewNotePage> createState() => _CreateANewNotePageState();
}

class _CreateANewNotePageState extends State<CreateANewNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isNewCategory.toString(),
        ),
      ),
    );
  }
}
