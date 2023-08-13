import 'package:flutter/material.dart';

void showAlertDialog({required BuildContext context,required Color backgroundColor,required Widget content,List<Widget>? actions}){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      backgroundColor: backgroundColor,
      elevation: 0,
      alignment: AlignmentDirectional.center,
      content: Padding(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: content
      ),
      actions: actions,
    );
  });
}