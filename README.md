# Tenis Antrenör Mobil Uygulaması

AI destekli paylaşımlı tenis antrenör asistanı konseptine dayalı, iki modlu (Kullanıcı + Antrenör) Flutter mobil uygulaması.

## Özellikler

- **Kullanıcı modu:** Giriş/kayıt, profil, plan seçme ve satın alma (demo), QR ile antrenman oturumuna katılma.
- **Antrenör modu:** Yeni oturum oluşturma, QR gösterme, kullanıcı bağlanınca süre sayacı, program ve kullanıcı verileri.

## Gereksinimler

- Flutter SDK (3.10+)
- Firebase projesi (Authentication + Firestore)
- Android Studio / Xcode (platform build için)

## Firebase Kurulumu

1. [Firebase Console](https://console.firebase.google.com/) üzerinden yeni bir proje oluşturun.
2. Projede **Authentication** (E-posta/Şifre) ve **Cloud Firestore** etkinleştirin.
3. **Android uygulaması ekleme**
   - Firebase Console’da proje ayarlarına gidin (dişli ikon → **Proje ayarları**).
   - **Genel** sekmesinde **Uygulamalar** bölümüne inin, **Android simgesi** ile “Uygulama ekle”yı tıklayın.
   - **Android paket adı** alanına tam olarak şunu yazın: `com.tenniscoach.tennis_mobile_app` (uygulama flavor’ları bu paket adını kullanıyor; ayrıca eklemenize gerek yok).
   - Uygulama takma adı (isteğe bağlı) ve Debug imzalama sertifikası SHA-1 (isteğe bağlı, Google Sign-In kullanacaksanız ekleyin) alanlarını doldurup **Uygulamayı kaydet**’e tıklayın.
   - İndirilen **google-services.json** dosyasını projenizin **`android/app/`** klasörüne kopyalayın (yani `android/app/google-services.json` konumunda olmalı). Mevcut bir dosya varsa üzerine yazın.
   - Android build’in Firebase’i tanıması için projede zaten `com.google.gms.google-services` eklentisi kullanılıyor; ek bir adım gerekmez.

4. **iOS uygulaması ekleme**
   - Firebase Console’da yine **Proje ayarları** → **Uygulamalar** bölümünde **iOS simgesi** ile “Uygulama ekle”yı tıklayın.
   - **iOS paket kimliği** (Bundle ID) alanına `com.tenniscoach.tennisMobileApp` yazın (Xcode’daki `ios/Runner.xcodeproj` veya `Runner/Info.plist` içindeki **Bundle Identifier** ile aynı olmalı).
   - Uygulama takma adı ve App Store ID (isteğe bağlı) alanlarını doldurup **Uygulamayı kaydet**’e tıklayın.
   - İndirilen **GoogleService-Info.plist** dosyasını Xcode ile projeye ekleyin:
     - Xcode’da `ios/Runner.xcworkspace` dosyasını açın (`.xcodeproj` değil).
     - Sol panelde **Runner** projesini seçin, **Runner** grubuna sağ tıklayıp **Add Files to "Runner"…** deyin.
     - İndirdiğiniz **GoogleService-Info.plist** dosyasını seçin; **Copy items if needed** işaretli, **Add to targets** kısmında **Runner** seçili olsun.
     - Dosya **Runner** grubu altında görünmeli ve `ios/Runner/GoogleService-Info.plist` yolunda olmalı. Bunu doğrulamak için Finder’da `ios/Runner` klasörüne bakabilirsiniz.

5. **`.firebaserc` içinde proje ID’sini güncelleme**
   - Firebase proje ID’nizi bulmak için: Firebase Console’da **Proje ayarları** → **Genel** sekmesinde **Proje ID** alanına bakın (örn. `tennis-coach-abc123`).
   - Proje kök dizinindeki **`.firebaserc`** dosyasını bir metin editörüyle açın.
   - `"default":"YOUR_PROJECT_ID"` ifadesindeki `YOUR_PROJECT_ID` kısmını kendi proje ID’nizle değiştirin. Örnek: `"default":"tennis-coach-abc123"`.
   - Kaydedin. Bu sayede `firebase deploy --only firestore:rules` gibi komutlar doğru projeye gidecektir.

### Firestore kurallarını dağıtma

```bash
# Firebase CLI kurulumu: npm install -g firebase-tools
firebase login
firebase deploy --only firestore:rules
```

### Örnek veri (isteğe bağlı)

Firestore’da `plans` koleksiyonuna örnek plan ekleyebilirsiniz:

| Alan          | Tür    | Örnek        |
|---------------|--------|--------------|
| name          | string | Aylık Plan   |
| price         | number | 199          |
| durationDays  | number | 30           |
| features      | array  | ["Özellik 1"] |

## Projeyi Çalıştırma

```bash
# Bağımlılıklar
flutter pub get

# Mod seçiminin açıldığı tek uygulama (geliştirme)
flutter run
```

### Flavor ile çalıştırma (Kullanıcı / Antrenör ayrı build)

```bash
# Kullanıcı uygulaması (splash sonrası doğrudan giriş ekranı)
flutter run --flavor user --dart-define=APP_FLAVOR=user

# Antrenör uygulaması (splash sonrası doğrudan antrenör başlangıç)
flutter run --flavor coach --dart-define=APP_FLAVOR=coach
```

### Fiziksel iPhone’da çalıştırma (kablo ile)

Cihaza yükleme uzun sürüyor veya **“Dart VM Service was not discovered after 60 seconds”** hatası alıyorsanız:

1. **Release modda çalıştırma** (debug bağlantısı beklemez, uygulama hızlı açılır):
   ```bash
   flutter run --release
   ```
2. **USB ve cihaz:** Farklı bir USB portu (tercihen Mac’e doğrudan), orijinal/veri kablosu kullanın. iPhone’da “Bu Bilgisayara Güven” deyin.
3. **Xcode / cihaz uyumu:** `libobjc.A.dylib` uyarısı genelde cihaz iOS sürümü Xcode’daki destekten yeni olduğunda çıkar. Xcode’u güncelleyin veya **Release** modda test edin.
4. **Log yakalama (uygulama zaten cihazda çalışıyorsa):**
   ```bash
   # Cihazdan Flutter/Dart logları (release build’de de çalışır)
   flutter logs
   ```
   Alternatif: macOS **Console.app** açın, sol taraftan iPhone’unuzu seçin, sağ üstte arama kutusuna `Runner` veya `tennis` yazarak uygulama loglarını filtreleyin.

### Release build

```bash
# Android APK
flutter build apk --flavor user --dart-define=APP_FLAVOR=user
flutter build apk --flavor coach --dart-define=APP_FLAVOR=coach

# iOS (Xcode ile imzalama gerekir)
```

Release için imzalama: `android/app/build.gradle.kts` içinde `signingConfigs` tanımlayıp `buildTypes.release` altında kullanın. iOS için Xcode’da signing & capabilities ayarlayın.

## Proje Yapısı

- `lib/core/` – Tema, router, flavor, sabitler, **design** (tasarım token’ları)
- `lib/features/` – auth, home, profile, plans, qr, coach_session, splash, match_mode, training_mode, challenge_mode
- `lib/shared/` – Ortak modeller (UserProfile, Plan, TrainingSession)
- `assets/` – Görseller, ikonlar, fontlar (tasarımcı çıktıları)
- `design/` – Ekran mockup’ları (referans)
- `firestore.rules` – Firestore güvenlik kuralları

Tasarımcı ile çalışma ve tasarım entegrasyonu için **[DESIGN_INTEGRATION.md](DESIGN_INTEGRATION.md)** dosyasına bakın.

## Sunulabilir Hale Getirme

- **Backend:** Firebase projesi zaten bulutta; sunumda aynı projeyi kullanabilirsiniz.
- **Uygulama:** Release APK/IPA veya Google Play Internal Testing / TestFlight ile paylaşım yapılabilir.
