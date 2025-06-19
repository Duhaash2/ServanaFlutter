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
    final responsive = (double base) => width * base / 375;

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width * 0.85,
          height: height * 0.12,
          margin: EdgeInsets.only(right: responsive(10), bottom: responsive(16)),
          padding: EdgeInsets.all(responsive(20)),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(responsive(24)),
            boxShadow: [
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
                backgroundColor: Colors.blue[100],
                child: Icon(
                  Icons,
                  size: responsive(36),
                  color: Colors.blue[900],
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
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: responsive(8)),
                    Text(
                     description,
                      style: TextStyle(
                        fontSize: responsive(14),
                        color: Colors.black54,
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
