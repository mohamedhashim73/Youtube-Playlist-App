import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart"),elevation:0,backgroundColor: Colors.transparent,foregroundColor: mainColor,),
      body: const Center(child: Text("Cart",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
    );
  }
}
