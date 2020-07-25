import 'package:flutter/material.dart';
import 'package:expense_manager/create.form.dart';

class Create1 extends StatelessWidget {
  static const String id = "create_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Tab")),
      body: Center(child: CreateForm()),
    );
  }
}