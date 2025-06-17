import 'package:flutter/material.dart';

class TopRatedWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double rating;
  final VoidCallback onPressed;
  final String? tag;
  final String? subtitle;
  final IconData? subtitleIcon;

  const TopRatedWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.rating,
    required this.onPressed,
    this.tag,
    this.subtitle,
    this.subtitleIcon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 375; // reference design width

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: scale * 170,
        margin: EdgeInsets.symmetric(horizontal: scale * 8, vertical: scale * 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(scale * 18),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: scale * 6,
              offset: Offset(0, scale * 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(scale * 18),
                    topRight: Radius.circular(scale * 18),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: scale * 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (tag != null)
                  Positioned(
                    bottom: scale * 4,
                    right: scale * 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: scale * 8,
                        vertical: scale * 4,
                      ),
                      decoration: BoxDecoration(
                        color: tag == "Verified"
                            ? Colors.grey[800]
                            : Colors.amber.shade600,
                        borderRadius: BorderRadius.circular(scale * 12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            tag == "Verified" ? Icons.verified : Icons.star,
                            color: Colors.white,
                            size: scale * 14,
                          ),
                          SizedBox(width: scale * 4),
                          Text(
                            tag!,
                            style: TextStyle(
                              fontSize: scale * 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: scale * 10,
                vertical: scale * 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: scale * 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: scale * 6),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: scale * 18),
                      SizedBox(width: scale * 3),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: scale * 14,
                        ),
                      ),
                      SizedBox(width: scale * 5),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: scale * 13,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: scale * 8),
                  if (subtitle != null)
                    Row(
                      children: [
                        Icon(
                          subtitleIcon ?? Icons.work_outline,
                          size: scale * 16,
                          color: Colors.teal,
                        ),
                        SizedBox(width: scale * 6),
                        Expanded(
                          child: Text(
                            subtitle!,
                            style: TextStyle(
                              fontSize: scale * 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
