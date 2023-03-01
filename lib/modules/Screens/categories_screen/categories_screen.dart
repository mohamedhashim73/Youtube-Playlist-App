import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
    );
  }
}
