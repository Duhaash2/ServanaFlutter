import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class HomeWorkerWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData Icons;
  final VoidCallback onTap;

  const HomeWorkerWidget({
    super.key,
    required this.title,
    required this.description,
    required this.Icons,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final responsive = (double base) => width * base / 375;

    // 🎨 Dark and Light Theme Colors
    final boxColor = isDark ? Colors.grey[500] : Colors.blue[50];
    final iconBgColor = isDark ? Colors.white38 : Colors.blue[100];
    final iconColor = isDark ? Color(0xFF203A43) : Colors.blue[900];
    final titleColor = isDark ? Colors.black87 : Colors.black87;
    final descColor = isDark ? Colors.black87 : Colors.black54;

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width * 0.95,
          height: height * 0.15,
          margin: EdgeInsets.only(right: responsive(10), bottom: responsive(16)),
          padding: EdgeInsets.all(responsive(20)),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(responsive(24)),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: responsive(12),
                  offset: Offset(0, responsive(6)),
                ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: responsive(38),
                backgroundColor: iconBgColor,
                child: Icon(
                  Icons,
                  size: responsive(36),
                  color: iconColor,
                ),
              ),
              SizedBox(width: responsive(16)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    title,
                      style: TextStyle(
                        fontSize: responsive(22),
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: responsive(8)),
                    Text(
                     description,
                      style: TextStyle(
                        fontSize: responsive(14),
                        color: descColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
