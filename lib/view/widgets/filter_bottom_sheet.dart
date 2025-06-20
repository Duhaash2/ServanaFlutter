import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final padding = screenWidth * 0.05;
    final titleFontSize = screenWidth * 0.045;
    final iconSize = screenWidth * 0.06;

    final local = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(padding),
      height: screenHeight * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            local.filterBy,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.trending_down, color: Colors.red, size: iconSize),
            title: Text(
              local.lowerPrice,
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.trending_up, color: Colors.green, size: iconSize),
            title: Text(
              local.higherPrice,
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.amber, size: iconSize),
            title: Text(
              local.topRated,
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
