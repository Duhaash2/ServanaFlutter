import 'package:flutter/material.dart';
import 'package:servana/view/screens/section_4/rating_screen.dart';

import '../../l10n/app_localizations.dart';

class HistoryWidget extends StatelessWidget {
  final String title;
  final String description;
  final String description1;
  final String date;
  final String? description2;
  final String price;

  const HistoryWidget({
    required this.title,
    required this.description,
    required this.description1,
    required this.date,
    this.description2,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final responsiveFont = (double base) => width * base / 375;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? Colors.grey[850] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.grey[400] : Colors.black87;
    final fadedTextColor = isDark ? Colors.grey[500] : Colors.grey;
   // final responsiveFont = (double base) => width * base / 375;

    return Container(
      width: width * 0.9,
      margin: const EdgeInsets.only(right: 10, bottom: 12),
      padding: EdgeInsets.all(responsiveFont(14)),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: responsiveFont(12)),

          // Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: responsiveFont(20),
                    fontWeight: FontWeight.bold,
                    color:  Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: responsiveFont(5)),
                Text(
                  description1,
                  style: TextStyle(
                    fontSize: responsiveFont(16),
                    fontWeight: FontWeight.w400,
                    color: subTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: responsiveFont(25)),
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: responsiveFont(13),
                        fontWeight: FontWeight.w400,
                        color: fadedTextColor,
                      ),
                    ),
                    SizedBox(width: responsiveFont(18)),
                    Text(
                      '${local.jd} $price/${local.hr}',
                      style: TextStyle(
                        fontSize: responsiveFont(13),
                        fontWeight: FontWeight.w600,
                        color: fadedTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsiveFont(8)),
              ],
            ),
          ),

          SizedBox(width: responsiveFont(10)),

          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RatingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1),
                  minimumSize: Size(responsiveFont(100), responsiveFont(36)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  local.rateWorker,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsiveFont(14),
                  ),
                ),
              ),
              SizedBox(height: responsiveFont(10)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.grey[700] : const Color(0xFFDAF6FF),
                  elevation: 0,
                  side: BorderSide(
                    color: isDark ? Colors.grey[700]! : const Color(0xFFDAF6FF),
                    width: 1,
                  ),
                  minimumSize: Size(responsiveFont(100), responsiveFont(36)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: responsiveFont(14),
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
