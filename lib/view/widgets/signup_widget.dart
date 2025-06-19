import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../l10n/app_localizations.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText; // Pass localized text here
  final TextInputType keyboardType;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: scale * 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        readOnly: readOnly,
        onTap: onTap,
        style: TextStyle(fontSize: scale * 14),
        decoration: InputDecoration(
          labelText: labelText, // Already localized from caller
          labelStyle: TextStyle(fontSize: scale * 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(scale * 12),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneInputField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = width / 375;

    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: scale * 8.0),
      child: IntlPhoneField(
        controller: controller,
        decoration: InputDecoration(
          labelText: local.phone_number,
          labelStyle: TextStyle(fontSize: scale * 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(scale * 12),
          ),
        ),
        initialCountryCode: 'JO',
        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ),
    );
  }
}
