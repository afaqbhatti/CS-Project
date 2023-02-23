import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextFeildSocialInfo extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String value;
  Function(String) onChange;

  TextFeildSocialInfo({
    required this.label,
    required this.controller,
    required this.value,
    required this.onChange,
  });

  @override
  State<TextFeildSocialInfo> createState() => _TextFeildSocialInfoState();
}

class _TextFeildSocialInfoState extends State<TextFeildSocialInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.value != null && widget.value != 'null') {
      widget.controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        onChanged: widget.onChange,
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.label,
        ),
        keyboardType: TextInputType.name,
      ),
    );
  }
}
