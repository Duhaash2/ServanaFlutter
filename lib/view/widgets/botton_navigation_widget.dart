import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class BottonNavigationWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottonNavigationWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Map hardcoded labels to localized keys
    String localizedLabel = switch (label.toLowerCase()) {
      'home' => localizations.home,
      'wallet' => localizations.wallet,
      'my_requests' => localizations.my_requests,
      'profile' => localizations.profile,
      _ => label,
    };

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue[900] : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              localizedLabel,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.blue[900] : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
