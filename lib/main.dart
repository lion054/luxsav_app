import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luxsav_companion/data/luxsav_snapshot.dart';
import 'package:luxsav_companion/language/app_localizations.dart';
import 'package:luxsav_companion/logic/controllers/google_map_pin_controller.dart';
import 'package:luxsav_companion/logic/controllers/theme_provider.dart';
import 'package:luxsav_companion/luxsav_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _registerFontLicenses();
  await LuxsavSnapshot.load();

  await Get.putAsync<Loc>(() => Loc().init(), permanent: true);

  await Get.putAsync<ThemeController>(
    () => ThemeController.init(),
    permanent: true,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const LuxSavApp()));
}

/// The bundled brand fonts are under the SIL Open Font License, which asks that
/// the licence ships with them. This makes them appear on the licences page.
void _registerFontLicenses() {
  const fonts = {'Cormorant Garamond': 'CormorantGaramond', 'Inter': 'Inter'};
  LicenseRegistry.addLicense(() async* {
    for (final entry in fonts.entries) {
      final text = await rootBundle.loadString(
        'assets/fonts/licenses/${entry.value}-OFL.txt',
      );
      yield LicenseEntryWithLineBreaks([entry.key], text);
    }
  });
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleMapPinController>(GoogleMapPinController());
  }
}
