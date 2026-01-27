import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback pressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: pressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        fixedSize: Size(50, 50),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
      ),
    );
  }
}
