import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../design/app_design.dart';

/// Masaüstü tarayıcıda uygulamayı sabit telefon boyutunda gösterir; dar ekranda
/// (gerçek telefon / dar pencere) tam genişlik kullanılır.
class WebMobileShell extends StatelessWidget {
  const WebMobileShell({super.key, required this.child});

  final Widget child;

  /// Geniş layout: en az bir kenar bu değerin üzerindeyse çerçeve uygulanır.
  static const double wideLayoutBreakpoint = 600;

  static const double _phoneWidth = 412;
  static const double _maxPhoneHeight = 932;
  static const double _verticalMargin = 24;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;

    final mq = MediaQuery.maybeOf(context);
    if (mq == null) return child;

    final w = mq.size.width;
    final h = mq.size.height;
    final shortest = w < h ? w : h;

    if (shortest < wideLayoutBreakpoint || w < wideLayoutBreakpoint) {
      return child;
    }

    final maxH = (h - _verticalMargin * 2).clamp(400.0, _maxPhoneHeight);
    var phoneW = _phoneWidth;
    var phoneH = phoneW * 19.5 / 9;
    if (phoneH > maxH) {
      phoneH = maxH;
      phoneW = phoneH * 9 / 19.5;
    }

    return ColoredBox(
      color: AppPalette.backgroundDark,
      child: Center(
        child: Container(
          width: phoneW,
          height: phoneH,
          decoration: BoxDecoration(
            color: AppPalette.backgroundDark,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: MediaQuery(
            data: mq.copyWith(
              size: Size(phoneW, phoneH),
              padding: EdgeInsets.zero,
              viewPadding: EdgeInsets.zero,
              viewInsets: mq.viewInsets,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
