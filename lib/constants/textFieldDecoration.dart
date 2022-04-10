import 'package:flutter/material.dart';

InputDecoration textFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8), fontSize: 12),
  enabledBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black12),
  ),
  focusedBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black12),
  ),
  border: const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black12),
  ),
);

const InputDecoration textFieldBorderedDecoration = const InputDecoration(
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
    helperText: "Name",
    hintText: "Name");
