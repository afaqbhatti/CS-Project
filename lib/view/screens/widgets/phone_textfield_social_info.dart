import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextFieldSocialInfo extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String value;
  Function(String) onChange;

  PhoneTextFieldSocialInfo({
    required this.label,
    required this.controller,
    required this.value,
    required this.onChange,
  });

  @override
  _PhoneTextFieldSocialInfoState createState() =>
      _PhoneTextFieldSocialInfoState();
}

class _PhoneTextFieldSocialInfoState extends State<PhoneTextFieldSocialInfo> {
  late String value;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.value != null && widget.value != 'null') {
        widget.controller.text = widget.value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        controller: widget.controller,
        onChanged: (String newValue) {
          setState(() {
            widget.controller.text;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.label,
          prefixIcon: Icon(Icons.plus_one),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-10]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.number,
      ),
    );
  }
}
