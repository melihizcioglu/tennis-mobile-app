import 'package:flutter/material.dart';

/// Tasarımcının verdiği değerlerin tek kaynağı.
/// Renk, spacing, tipografi güncellemeleri bu dosyada yapılır;
/// [AppTheme] gibi yerlerde bu sınıflar kullanılır.

// ----- Renkler (tasarımcıdan hex olarak alınır: #RRGGBB → 0xFFRRGGBB) -----
class AppPalette {
  const AppPalette._();

  /// Lime vurgular (başlıklar, ikonlar, odak çizgisi)
  static const Color primary = Color(0xFFB7FF2A);
  static const Color primaryDark = Color(0xFF2D2D2D);
  static const Color secondary = Color(0xFFB8F5C5);
  static const Color accent = Color(0xFFB7FF2A);

  /// İşlevsel ana butonlar (Get Started, Create Account, Giriş Yap vb.)
  static const Color ctaButton = Color(0xFF8F92FD);

  /// Arka plan (tüm koyu ekranlar)
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color backgroundLight = Color(0xFFB8F5C5); // Açık ekranlar (welcome, games mode)

  /// Metin
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnLight = Color(0xFF1C1C1C);
  static const Color textSecondaryLight = Color(0xFF666666);
  static const Color textSecondaryDark = Color(0xFFCCCCCC);

  /// Kart (Page 4 koyu mod kartları)
  static const Color cardDark = Color(0xFF2D2D2D);

  /// Durum
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFB00020);
  static const Color warning = Color(0xFFFF9800);
}

// ----- Boşluklar (tasarımcıdan px; Flutter'da logical pixel olarak aynı sayı) -----
class AppSpacing {
  const AppSpacing._();

  /// Tasarım: ana CTA genişlik/yükseklik (Get Started, Giriş Yap, …)
  static const double ctaButtonWidth = 360;
  static const double ctaButtonHeight = 62;

  /// Kayıt ekranı: lime başlık alanı, mor CTA
  static const double registerTitleWidth = 300;
  static const double registerTitleHeight = 57;
  static const double registerCtaWidth = 370;
  static const double registerCtaHeight = 86;

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// Figma mobil frame (PAGE 2 giriş/kayıt, PAGE 3 ana ekran, PAGE 4 vb.).
  static const double figmaFrameWidth = 492;
  static const double figmaFrameHeight = 874;

  /// PAGE 3 ile uyumluluk için alias.
  static const double homeFigmaFrameWidth = figmaFrameWidth;

  /// Dar ekranda tasarım 492’ye göre oransal küçülür; geniş tablette içerik 492’de kalır.
  static double figmaScale(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final contentW = w < figmaFrameWidth ? w : figmaFrameWidth;
    return contentW / figmaFrameWidth;
  }

  static const EdgeInsets paddingScreen = EdgeInsets.all(md);
  static const EdgeInsets paddingCard = EdgeInsets.all(md);
}

// ----- Border radius (tasarımcıdan px) -----
class AppRadius {
  const AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;
}

// ----- Tipografi (tasarımcı font + boyut verdiğinde buraya yazılır) -----
class AppTypography {
  const AppTypography._();

  /// Varsayılan font ailesi. Tasarımcı font verirse pubspec'e ekleyip buraya yazın.
  static const String fontFamily = 'Roboto';

  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: fontFamily,
          );

  static TextStyle titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: fontFamily,
          );

  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontFamily: fontFamily,
          );

  static TextStyle bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontFamily: fontFamily,
          );
}

// ----- Asset yolları (tasarımcı görsel/ikon verdiğinde buraya ekleyin) -----
class AppAssets {
  const AppAssets._();

  static const String imagesRoot = 'assets/images';
  static const String iconsRoot = 'assets/icons';

  // Page 1 – Landing (arka plan düz renk; PNG katmanları)
  static const String landingBackground = '$iconsRoot/ARKA PLAN.png';
  static const String sharedLayer = '$iconsRoot/SHARED.png';
  static const String slogan = '$iconsRoot/SLOGAN.png';
  static const String duoLogo = '$iconsRoot/DUO LOGO.png';
  static const String getStartedButton = '$iconsRoot/GET STARTED BUTTON.png';

  // Page 2 – Giriş / kayıt (PNG katmanları, 492×874 Figma frame ile aynı ölçek)
  static const String createAccountTitle = '$iconsRoot/CREATE ACCOUNT.png';
  static const String createAccountButton = '$iconsRoot/CREATE ACCOUNT BUTTON.png';
  /// Tam ekran alan PNG’leri üst üste bindiğinde çift kutu oluşturduğu için
  /// auth ekranlarında kullanılmıyor; dosyalar assets’te kalabilir.
  static const String authUsername = '$iconsRoot/USERNAME.png';
  static const String authEmail = '$iconsRoot/EMAIL.png';
  static const String authPassword = '$iconsRoot/PASSWORD.png';
  static const String haveAccountFooter = '$iconsRoot/HAVE AN ACCOUNT.png';
  static const String signInTitle = '$iconsRoot/SIGN IN.png';

  // Page 3 – Ana ekran (dashboard), standardize edilmiş asset adları.
  static const String homeInfoButton = '$iconsRoot/home_info.png';
  static const String homeSettingsButton = '$iconsRoot/home_settings.png';
  static const String homeProfileButton = '$iconsRoot/home_profile.png';
  static const String homeStartPlayingButton = '$iconsRoot/home_start_playing.png';
  static const String homeRentNow = '$iconsRoot/home_rent_now.png';
  static const String homeGameModes = '$iconsRoot/home_game_modes.png';
  static const String homeFindDuo = '$iconsRoot/home_find_duo.png';
  static const String homeReservations = '$iconsRoot/home_reservations.png';
  static const String homeSelectPlan = '$iconsRoot/home_select_plan.png';
  static const String homeFooterBot = '$iconsRoot/home_chat_bot.png';

  // Page 4 – Oyun modları listesi
  static const String backButton = '$iconsRoot/BACK BUTTON_CROPPED.png';
  static const String gameModesTitle = '$iconsRoot/GAMES MODE_TITLE_CROPPED.png';
  static const String trainingMode = '$iconsRoot/TRAINING MODE_CROPPED.png';
  static const String matchMode = '$iconsRoot/MATCH MODE_CROPPED.png';
  static const String challengeMode = '$iconsRoot/CHALLENGE MODE_CROPPED.png';
  static const String chatbotTrainingMode =
      '$iconsRoot/CHAT-BOT TRAINING_CROPPED.png';
}
