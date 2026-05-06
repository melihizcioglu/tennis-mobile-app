import '../app_mode.dart';

/// Build flavor: user veya coach. Boş ise uygulama başlangıçta mod seçimi gösterir.
const String _flavor = String.fromEnvironment(
  'APP_FLAVOR',
  // Bu aşamada "coach" modunu rafa kaldırıyoruz; varsayılanı user yap.
  // Böylece `--flavor user` kullanmasan bile uygulama user akışına düşer.
  defaultValue: 'user',
);

/// Mevcut flavor'a göre uygulama modu.
AppMode? get appFlavorMode {
  switch (_flavor) {
    case 'user':
      return AppMode.user;
    case 'coach':
      return AppMode.coach;
    default:
      // Varsayılan 'user' olduğu için buraya genelde düşmez.
      return AppMode.user;
  }
}

bool get isUserFlavor => _flavor == 'user';
bool get isCoachFlavor => _flavor == 'coach';
