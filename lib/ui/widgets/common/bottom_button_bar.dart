import 'package:flutter/material.dart';

class BottomButtonBar extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const BottomButtonBar({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 16),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            letterSpacing: 1.4,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
