import 'package:flutter/material.dart';

class ReplaceExercisePage extends StatelessWidget{
  const ReplaceExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replace Exercise'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text('Replace Exercise Page Content Here'),
      ),
    );
  }
}