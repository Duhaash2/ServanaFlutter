import 'package:flutter/material.dart';

class BottonNavigationWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottonNavigationWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: width * 0.015),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: width * 0.06, // Responsive icon size
                color: isSelected ? Colors.blue[900] : Colors.grey,
              ),
              SizedBox(height: width * 0.01), // Responsive spacing
              Text(
                label,
                style: TextStyle(
                  fontSize: width * 0.035, // Around 14 for mid-size screens
                  color: isSelected ? Colors.blue[900] : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
