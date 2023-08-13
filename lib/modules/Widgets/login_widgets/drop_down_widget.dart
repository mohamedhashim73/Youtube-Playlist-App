import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  const DropDownWidget({Key? key,required this.items,this.value,required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: items.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
      value: value,
      onChanged: onChanged
    );
  }
}
