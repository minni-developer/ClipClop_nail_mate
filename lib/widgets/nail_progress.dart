import 'package:flutter/material.dart';

class NailProgress extends StatelessWidget {
  final double progress;
  final Color color;
  
  const NailProgress({
    Key? key, 
    required this.progress,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'NAIL GROWTH PROGRESS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 15),
        Stack(
          children: [
            Container(
              height: 20,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
              width: 250 * progress.clamp(0.0, 1.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    color,
                    color.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}