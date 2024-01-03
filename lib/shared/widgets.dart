import 'package:flutter/material.dart';

class PrimaryContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final double iconSize;
  final double fontSize;

  const PrimaryContainer(
      {super.key,
      required this.icon,
      required this.title,
      required this.child,
      this.iconSize = 16,
      this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: BoxConstraints.tightFor(),
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(10.0),
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
              const SizedBox(width: 5),
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
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
