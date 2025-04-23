import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    required this.color,
    required this.onpress,
    required this.icon,
  });
  final color;
  final VoidCallback onpress;
  final icon;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onpress,
      elevation: 10.0,
      fillColor: color,
      padding: EdgeInsets.all(12.0),
      shape: CircleBorder(),
      child: Icon(icon, size: 30.0, color: Colors.white),
    );
  }
}
