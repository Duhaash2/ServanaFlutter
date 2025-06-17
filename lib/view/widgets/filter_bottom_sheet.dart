import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final padding = screenWidth * 0.05; // ≈ 20 on 400px width
    final titleFontSize = screenWidth * 0.045; // ≈ 18 on 400px width
    final iconSize = screenWidth * 0.06; // ≈ 24 on 400px width

    return Container(
      padding: EdgeInsets.all(padding),
      height: screenHeight * 0.3, // ≈ 250 on 800px height
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter By",
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.trending_up, color: Colors.green, size: iconSize),
            title: Text(
              "Lower Price",
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.trending_down, color: Colors.red, size: iconSize),
            title: Text(
              "Higher Price",
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.amber, size: iconSize),
            title: Text(
              "Top Rated",
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
