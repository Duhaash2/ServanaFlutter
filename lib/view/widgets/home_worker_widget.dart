import 'package:flutter/material.dart';

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
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 380,
          height: 120, // ⬆️ Increase box height
          margin: const EdgeInsets.only(right: 10, bottom: 16),
          padding: const EdgeInsets.all(20), // ⬆️ More inner spacing
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 38, // ⬆️ Bigger circle
                backgroundColor: Colors.blue[100],
                child: Icon(
                  Icons,
                  size: 36, // ⬆️ Bigger icon
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22, // ⬆️ Bigger title
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
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
