import 'package:flutter/material.dart';

import '../../../core/design/app_design.dart';

/// Auth ekranlarında tema [InputDecorationTheme] ile birleşip çift kutu / bej dolgu
/// oluşturmasın diye tüm kenarlık ve dolgu burada açıkça verilir.
class AuthFieldStyles {
  AuthFieldStyles._();

  static const double capsuleRadius = 28;

  static InputDecoration authCapsule({
    Widget? suffixIcon,
  }) {
    final none = OutlineInputBorder(
      borderRadius: BorderRadius.circular(capsuleRadius),
      borderSide: BorderSide.none,
    );
    return InputDecoration(
      isDense: false,
      filled: true,
      fillColor: Colors.white,
      border: none,
      enabledBorder: none,
      disabledBorder: none,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(capsuleRadius),
        borderSide: const BorderSide(color: AppPalette.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(capsuleRadius),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(capsuleRadius),
        borderSide: const BorderSide(color: AppPalette.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
    );
  }

  static TextStyle fieldText(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppPalette.textOnLight,
            fontWeight: FontWeight.w600,
          );
}
