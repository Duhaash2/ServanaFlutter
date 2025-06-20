import 'package:flutter/material.dart';

class CategoryButtonWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onPressed;
  final String ImagePath;

  const CategoryButtonWidget({
    required this.title,
    this.icon,
    this.isSelected = false,
    this.onPressed,
    required this.ImagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    final imageSize = screenWidth * 0.19; // ~76px on 400px width
    final fontSize = screenWidth * 0.04; // ~16px on 400px width

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                ImagePath,
                height: imageSize,
                width: imageSize,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenWidth * 0.015),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.orange
                    : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
