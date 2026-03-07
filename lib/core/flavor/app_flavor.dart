import '../app_mode.dart';

/// Build flavor: user veya coach. Boş ise uygulama başlangıçta mod seçimi gösterir.
const String _flavor = String.fromEnvironment(
  'APP_FLAVOR',
  defaultValue: '',
);

/// Mevcut flavor'a göre uygulama modu. Boş ise null (mod seçimi gösterilir).
AppMode? get appFlavorMode {
  switch (_flavor) {
    case 'user':
      return AppMode.user;
    case 'coach':
      return AppMode.coach;
    default:
      return null;
  }
}

bool get isUserFlavor => _flavor == 'user';
bool get isCoachFlavor => _flavor == 'coach';
