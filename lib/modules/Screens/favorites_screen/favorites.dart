import 'package:flutter/material.dart';

import '../../../shared/style/colors.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites"),elevation:0,backgroundColor: Colors.transparent,foregroundColor: mainColor,),
      body: const Center(child: Text("Favorites",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
    );
  }
}
