import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luxsav_companion/language/app_localizations.dart';
import 'package:luxsav_companion/logic/controllers/google_map_pin_controller.dart';
import 'package:luxsav_companion/logic/controllers/theme_provider.dart';
import 'package:luxsav_companion/luxsav_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync<Loc>(() => Loc().init(), permanent: true);

  await Get.putAsync<ThemeController>(() => ThemeController.init(),
      permanent: true);

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const LuxSavApp()));
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleMapPinController>(GoogleMapPinController());
  }
}
