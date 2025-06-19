import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class PlumingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double rating;
  final String price;
  final VoidCallback onPressed;
  final String? whatsappNumber;

  const PlumingWidget({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.rating,
    required this.price,
    required this.onPressed,
    this.whatsappNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;

    return Container(
      width: scale * 370,
      margin: EdgeInsets.only(right: scale * 10, bottom: scale * 12),
      padding: EdgeInsets.all(scale * 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.blue[50],
        borderRadius: BorderRadius.circular(scale * 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: scale * 40,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(width: scale * 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: scale * 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: scale * 6),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      itemCount: 5,
                      itemSize: scale * 20.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: scale * 6),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: scale * 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: scale * 6),
                Row(
                  children: [
                    Text(
                      'JD $price/hr',
                      style: TextStyle(
                        fontSize: scale * 17,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D47A1),
                      ),
                    ),
                    SizedBox(width: scale * 80),
                    TextButton(
                      onPressed: onPressed,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(scale * 50, scale * 20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        description,
                        style: TextStyle(
                          fontSize: scale * 13,
                          color: const Color(0xFF0D47A1),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            children: [
              SizedBox(height: scale * 6),

            ],
          ),
        ],
      ),
    );
  }
}
