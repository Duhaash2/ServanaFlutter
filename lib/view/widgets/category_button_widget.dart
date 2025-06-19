import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

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
    final imageSize = screenWidth * 0.19;
    final fontSize = screenWidth * 0.04;

    // 🔤 Localization
    final localizations = AppLocalizations.of(context)!;

    String localizedTitle = switch (title.toLowerCase()) {
      'plumbing' => localizations.plumbing,
      'electrical' => localizations.electrical,
      'cleaning' => localizations.cleaning,
      'hvac' => localizations.hvac,
      _ => title,
    };

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
              localizedTitle,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.orange : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
