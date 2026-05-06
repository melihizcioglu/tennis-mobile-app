f# Tasarımcı ile Çalışma ve Tasarım Entegrasyonu

Bu dokümanda **Figma** ile tasarlanan çıktıların projede nasıl kullanılacağı ve nereye konulacağı anlatılır. Tasarım aracı: **Figma**.

---

## 0. Ne Zaman Entegre Edelim? (En son mu, adım adım mı?)

**Öneri: Figma tasarımlarını en sona bırakmayın; entegre ede ede gidin.** Fark şöyle:

| Yaklaşım | Avantaj | Dezavantaj |
|----------|--------|------------|
| **En son entegre** | Önce "işe yarar" ekranlar çıkar, tasarım sonra uyar. | Sonunda büyük bir "tasarım geçişi" gerekir; birçok ekranı baştan düzeltmek, renk/spacing değiştirmek zorunda kalırsınız. Tasarımcı geri bildirimini geç alırsınız. |
| **Entegre ede ede** | Tasarım ve kod sürekli uyumlu kalır. Tasarımcı erken geri bildirim verir. Renk/spacing bir kez `app_design.dart`'a alındığında tüm ekranlar aynı dili konuşur. | Her ekran için Figma'ya bakma disiplini gerekir. |

**Pratik öneri:**

1. **Başta (ilk sprint / ilk hafta):** Figma'daki **renk, spacing, tipografi, radius** değerlerini alıp **`app_design.dart`** ve temaya yazın. Böylece "tasarım dili" projede tek kaynaktan gelir.
2. **Her yeni ekran/özellik yaparken:** O ekranın Figma'sı hazırsa, ekranı **o tasarıma göre** kodlayın; "önce çirkin yapayım sonra düzeltirim" demeyin.
3. **Tasarım henüz yoksa:** Placeholder (geçici) renk ve layout kullanın; tasarım gelince sadece o ekranı Figma'ya göre güncelleyin.

Sonuç: **En son tek seferde entegre etmek** yerine **her ekranı tasarım hazır oldukça entegre etmek** daha az tekrar iş ve daha iyi tasarım–kod uyumu sağlar. Fark, en sonda yaşanacak büyük refactoring'in dağıtılıp küçük küçük yapılmasıdır.

---

## 1. Figma’dan İstenecekler

### 1.1 Erişim

- **Paylaşım linki**: Tasarımcı Figma dosyasını “can edit” veya “can view” ile paylaşsın. Geliştirici linke tıklayıp tarayıcıda veya Figma masaüstü uygulamasında açar.
- **Dev Mode** (ücretli plan): Varsa açık olsun; renk, spacing, font doğrudan panelden kopyalanır.

### 1.2 Her ekran için

- **Ekran tasarımı**: Figma’da ilgili frame’e link (ör. “Ana sayfa”, “Maç kurulumu”). Gerekirse export → PNG/PDF `design/screens/` içine referans olarak konur.
- **Spesifikasyon**: Figma’da eleman seçildiğinde sağ panelde (Inspect / Dev Mode) görünen:
  - **Renk**: Hex (örn. `#2E7D32`) — Flutter’da `0xFF2E7D32`
  - **Tipografi**: Font adı, boyut (px), ağırlık (Regular/Bold)
  - **Boşluklar**: Padding/margin (8, 16, 24 px)
  - **Köşe**: Border radius (px)
  - **İkonlar / görseller**: Hangi ekranda hangi asset kullanılıyor

### 1.3 Asset’ler (Figma’dan export)

- **Görseller**: Frame veya grup seç → sağ panel **Export** → PNG (1x, 2x, 3x) veya **SVG**. Projede `assets/images/`.
- **İkonlar**: İkon frame’i seç → Export → **SVG** (tercih) veya PNG. Projede `assets/icons/`. Flutter’da SVG için `flutter_svg` kullanılır.
- **Fontlar**: Figma’da kullanılan fontların lisansı varsa tasarımcı `.ttf` / `.otf` sağlar → `assets/fonts/` ve `pubspec.yaml` fonts bölümü.

---

## 2. Projede Nereye Koyulacak?

```
tennis-mobile-app/
├── assets/
│   ├── images/          # Görseller (logo, arka plan, illüstrasyon)
│   ├── icons/           # Uygulama ikonları (SVG/PNG)
│   └── fonts/           # Tasarımcının verdiği font dosyaları
├── design/              # (İsteğe bağlı) Tasarımcının ham çıktıları
│   ├── screens/         # Ekran mockup’ları (referans)
│   └── exports/         # Figma/XD’den export edilen asset’ler
└── lib/
    └── core/
        └── design/      # Tasarım değerleri (renk, spacing, tipografi)
            ├── app_design.dart   # Tasarımcının renk/spacing/font değerleri
            └── app_theme.dart   # Flutter tema (app_design kullanır)
```

- **Kodda kullanılacak her şey** → `assets/` altında; `pubspec.yaml` içinde tanımlanır.
- **Sadece referans** (ekran görüntüsü, PDF) → `design/` altında; projeye dahil edilir, build’e girmez.

---

## 3. Adım Adım Entegrasyon

### Adım 1: Asset’leri yerleştir

- Görseller → `assets/images/`
- İkonlar → `assets/icons/`
- Fontlar → `assets/fonts/`

`pubspec.yaml` içinde şu bölümü güncelle (örnek):

```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
  fonts:
    - family: OurCustomFont
      fonts:
        - asset: assets/fonts/OurFont-Regular.ttf
        - asset: assets/fonts/OurFont-Bold.ttf
          weight: 700
```

### Adım 2: Tasarım değerlerini tek yere yaz

Tasarımcının verdiği renk, spacing ve font bilgilerini **`lib/core/design/app_design.dart`** dosyasına yazın. Bu dosya tek kaynak olur; tema (`app_theme.dart`) buradan okur.

- Renkler → `AppDesign.Palette`
- Boşluklar → `AppDesign.Spacing`
- Font ailesi / boyutları → `AppDesign.Typography`
- Border radius, gölge vb. → aynı dosyada sabitler

Tasarımcı yeni değer verdiğinde sadece `app_design.dart` güncellenir.

### Adım 3: Temayı tasarıma bağla

`lib/core/theme/app_theme.dart` içinde:

- `ColorScheme` ve diğer renkler → `AppDesign.Palette` ile
- `EdgeInsets` örnekleri → `AppDesign.Spacing` ile
- `TextTheme` → `AppDesign.Typography` (ve font family) ile

Böylece tüm uygulama tasarımcının paletine ve spacing’ine uyar.

### Adım 4: Ekranları tasarıma göre uyarla

- Ekran layout’u: tasarımda kaç column/row, hangi padding varsa aynısını kullanın.
- Metin stilleri: `Theme.of(context).textTheme.titleLarge` vb. veya `AppTypography` sabitleri.
- Renk: `Theme.of(context).colorScheme.primary` veya `AppDesign.Palette.primary`.
- Görsel kullanımı: `Image.asset('assets/images/...')`, ikonlar için `Image.asset('assets/icons/...')` veya `SvgPicture.asset(...)`.

---

## 4. Figma ile Günlük Akış

Tasarımcı Figma’da tasarlıyor; siz değerleri ve asset’leri alıp projeye taşıyorsunuz.

### 4.1 Değerleri kopyalamak (renk, spacing, font, radius)

1. Figma’da ilgili elemanı seçin (metin, kutu, buton).
2. Sağ panelde **Inspect** (veya **Dev Mode**) açın.
3. **Renk**: Üzerine tıklayınca hex çıkar (örn. `#2E7D32`) → Flutter’da `Color(0xFF2E7D32)` (başına `0xFF` ekleyin). Bu değeri `lib/core/design/app_design.dart` → `AppDesign.Palette` içine yazın.
4. **Boyut / boşluk**: Padding, margin, width, height px olarak görünür → `AppDesign.Spacing` veya doğrudan `EdgeInsets.all(16)` gibi kullanın.
5. **Yazı**: Font adı, size (px), weight → `AppDesign.Typography` veya tema `TextStyle`’larına yansıtın.
6. **Köşe yuvarlaklığı**: Border radius (px) → `AppDesign.Radius` veya `BorderRadius.circular(12)`.

Özet: Tüm bu değerlerin tek kaynağı **`app_design.dart`**; Figma’dan kopyala-yapıştır bu dosyaya yapılır.

### 4.2 Görsel ve ikon export (Figma → proje)

1. Figma’da görseli/ikonu içeren frame’i veya grubu seçin.
2. Sağ panel **Export** bölümüne gidin.
3. **Format**: Görseller için **PNG (2x veya 3x)** tercih edin. İkonlar için SVG; ancak Figma SVG'leri bazen gömülü base64 image içerir, bu durumda `flutter_svg` render edemez → **PNG kullanın**.
4. Export’a tıklayıp indirin.
5. Dosyayı projede ilgili yere koyun:
   - Görseller → `assets/images/`
   - İkonlar → `assets/icons/`
6. Gerekirse `app_design.dart` → `AppDesign.Assets` içine path sabiti ekleyin (örn. `logo`, `iconHome`).

Not: `pubspec.yaml`’da `assets/images/` ve `assets/icons/` zaten tanımlı; yeni dosya eklemek yeterli.

### 4.3 Figma eklentileri (isteğe bağlı)

- **Figma to Flutter**: Seçili frame’i Flutter widget kodu olarak export eder. Yeni bir ekranı hızlı iskeletlemek için kullanılabilir; çıkan kodu proje yapınıza (router, tema, `app_design`) göre sadeleştirip uyarlayın.
- **Design tokens**: Figma’da Variables / Styles kullanılıyorsa, renk ve spacing’i tek yerden yönetirsiniz; Flutter tarafında bu değerleri manuel olarak `app_design.dart` ile eşitleyin.

### 4.4 Link ile referans

Tasarımcı “Ana sayfa şöyle olsun” dediğinde: Figma’da ilgili frame’e sağ tık → **Copy link to frame**. Bu linki ticket’a veya PR açıklamasına yapıştırın; ekranı kodlarken aynı frame’i açıp Inspect ile değerlere bakarsınız.

---

## 5. Tasarımcıyla Ortak Dil (Figma odaklı)

- **Spacing:** “Bu blokta 16px padding” → Figma Inspect’te 16 görünür → `AppDesign.Spacing.md` veya `EdgeInsets.all(AppDesign.Spacing.md)`.
- **Renk:** “Primary yeşil #2E7D32” → Figma’da renk seçildiğinde hex kopyalanır → `AppDesign.Palette.primary` = `Color(0xFF2E7D32)` (hex’te # → 0xFF).
- **Font:** “Başlık 20px, bold” → Figma’da text seçilince font/size/weight görünür → `AppDesign.Typography` ve tema `TextStyle`’larına yazılır.

Tasarımcıya söyleyebileceğiniz:  
*“Tasarımları Figma’da tut; ben ekranları kodlarken Inspect / Dev Mode’dan renk, spacing ve font değerlerini alıp `app_design.dart`’a taşıyorum. Görsel ve ikonları da Figma’dan export edip projeye ekliyorum.”*

---

## 6. Özet Checklist

| Tasarımcı verdiği        | Projede nereye              | Kodda nasıl kullanılır                    |
|--------------------------|----------------------------|-------------------------------------------|
| Renk paleti (hex)        | `lib/core/design/app_design.dart` | `AppDesign.Palette.primary`, tema         |
| Boşluklar (px)           | `app_design.dart`          | `AppDesign.Spacing.md`, `EdgeInsets`             |
| Font dosyaları           | `assets/fonts/` + pubspec  | `AppDesign.Typography`, `TextStyle`       |
| Görseller / ikonlar      | `assets/images/`, `icons/` | `Image.asset()`, `AppDesign.Assets`     |
| Ekran mockup’ları        | `design/screens/`         | Referans; kod `app_design` + layout       |

Bu yapı ile tasarımcının verdiği her çıktı projede net bir yere sahip olur ve tek yerden güncellenir.
