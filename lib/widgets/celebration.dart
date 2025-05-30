import 'package:flutter/material.dart';

class CelebrationOverlay extends StatelessWidget {
  final VoidCallback onContinue;

  const CelebrationOverlay({Key? key, required this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A2B3C),
                  Color(0xFF4A6B8A),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '✂️',
                  style: TextStyle(fontSize: 60),
                ),
                SizedBox(height: 20),
                Text(
                  'Nails Trimmed!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Looking sharp and clean!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onContinue,
                  child: Text('CONTINUE'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFF1A2B3C), backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}