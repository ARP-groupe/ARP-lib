import 'package:flutter/material.dart';

class Section {
  bool enable;
  bool visible;
  String name;
  IconData icon;
  Color? color;
  Widget child;

  Section({
    this.enable = true,
    this.visible = true,
    required this.name,
    required this.icon,
    this.color,
    required this.child,
  });
}
