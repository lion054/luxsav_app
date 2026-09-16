import 'package:flutter/material.dart';
import 'package:luxsav_companion/constants/luxsav_brand.dart';
import 'package:get/get.dart';
import 'package:luxsav_companion/constants/localfiles.dart';
import 'package:luxsav_companion/constants/text_styles.dart';
import 'package:luxsav_companion/constants/themes.dart';
import 'package:luxsav_companion/language/app_localizations.dart';
import 'package:luxsav_companion/logic/controllers/theme_provider.dart';
import 'package:luxsav_companion/routes/route_names.dart';
import 'package:luxsav_companion/widgets/common_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoadText = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _loadAppLocalizations(),
    ); // call after first frame receiver so we have context
    super.initState();
  }

  Future<void> _loadAppLocalizations() async {
    try {
      setState(() {
        isLoadText = true;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: !Get.find<ThemeController>().isLightMode
                ? BoxDecoration(
                    color: Theme.of(
                      context,
                    ).scaffoldBackgroundColor.withOpacity(0.4),
                  )
                : null,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(Localfiles.introduction, fit: BoxFit.cover),
          ),
          // Victoria Falls is bright at the top and busy at the bottom, so a
          // charcoal gradient keeps the logo and buttons legible over it.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.35, 0.6, 1.0],
                colors: [
                  LuxColors.charcoal.withValues(alpha: 0.55),
                  LuxColors.charcoal.withValues(alpha: 0.15),
                  LuxColors.charcoal.withValues(alpha: 0.15),
                  LuxColors.charcoal.withValues(alpha: 0.75),
                ],
              ),
            ),
            child: const SizedBox.expand(),
          ),
          Column(
            children: <Widget>[
              const Expanded(flex: 1, child: SizedBox()),
              Center(
                child: Image.asset(
                  Localfiles.logoWhite,
                  width: 220,
                  semanticLabel: 'LuxSav',
                ),
              ),
              const SizedBox(height: 8),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 420),
                child: Text(
                  Loc.alized.best_hotel_deals,
                  textAlign: TextAlign.center,
                  style: TextStyles(
                    context,
                  ).regular().copyWith(color: AppTheme.whiteColor),
                ),
              ),
              const Expanded(flex: 4, child: SizedBox()),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 680),
                child: CommonButton(
                  padding: const EdgeInsets.only(
                    left: 48,
                    right: 48,
                    bottom: 8,
                    top: 8,
                  ),
                  buttonText: Loc.alized.get_started,
                  onTap: () {
                    NavigationServices(context).gotoIntroductionScreen();
                  },
                ),
              ),
              AnimatedOpacity(
                opacity: isLoadText ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1200),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                    top: 16,
                  ),
                  child: Text(
                    Loc.alized.already_have_account,
                    textAlign: TextAlign.left,
                    style: TextStyles(
                      context,
                    ).description().copyWith(color: AppTheme.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
