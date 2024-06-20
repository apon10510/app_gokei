import 'package:flutter/material.dart';

class AlertDialogField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  const AlertDialogField(
      {super.key, this.textEditingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
