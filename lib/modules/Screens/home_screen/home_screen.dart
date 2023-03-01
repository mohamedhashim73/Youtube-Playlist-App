import 'package:flutter/material.dart';

import '../../../shared/style/colors.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fashion store"),elevation:0,backgroundColor: Colors.transparent,foregroundColor: mainColor,),
      body: const Center(child: Text("Home",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
    );
  }
}
