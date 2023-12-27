import 'package:flutter/material.dart';

class PrimaryContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final double iconSize = 16;
  final double fontSize = 24;

  const PrimaryContainer({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(width: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.1,
                  fontFamily: 'Poppins',
                  fontSize: fontSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
