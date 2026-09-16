import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:luxsav_companion/constants/luxsav_brand.dart';
import 'package:luxsav_companion/constants/text_styles.dart';
import 'package:luxsav_companion/constants/themes.dart';
import 'package:luxsav_companion/language/app_localizations.dart';
import 'package:luxsav_companion/logic/controllers/theme_provider.dart';
import 'package:luxsav_companion/modules/bottom_tab/components/tab_button_ui.dart';
import 'package:luxsav_companion/modules/tanova/tanova_screen.dart';
import 'package:luxsav_companion/modules/today/today_screen.dart';
import 'package:luxsav_companion/widgets/common_card.dart';
import '../explore/home_explore.dart';
import '../myTrips/my_trips_screen.dart';
import '../profile/profile_screen.dart';

/// The LuxSav shell: Today · Trip · Tanova · Explore · You.
///
/// The kit had three tabs (Explore, Trips, Profile). The strategy's five-tab
/// layout, with Tanova as a raised centre button, comes from the `luxsav_app`
/// scaffold. The app opens on Today.
class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({Key? key}) : super(key: key);

  @override
  State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFirstTime = true;
  Widget _indexView = Container();
  BottomBarType bottomBarType = BottomBarType.today;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      _isFirstTime = false;
      _indexView = _viewFor(BottomBarType.today);
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _viewFor(BottomBarType type) {
    switch (type) {
      case BottomBarType.today:
        return TodayScreen(
          animationController: _animationController,
          onPlanTrip: () => tabClick(BottomBarType.tanova),
        );
      case BottomBarType.trip:
        return MyTripsScreen(animationController: _animationController);
      case BottomBarType.tanova:
        return TanovaScreen(animationController: _animationController);
      case BottomBarType.explore:
        return HomeExploreScreen(animationController: _animationController);
      case BottomBarType.you:
        return ProfileScreen(animationController: _animationController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 64 + MediaQuery.of(context).padding.bottom,
        child: getBottomBarUI(bottomBarType),
      ),
      body: _isFirstTime
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : _indexView,
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType == bottomBarType) return;
    bottomBarType = tabType;
    _animationController.reverse().then((_) {
      setState(() => _indexView = _viewFor(tabType));
    });
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return GetBuilder<ThemeController>(
      builder: (_) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            CommonCard(
              color: AppTheme.backgroundColor,
              radius: 0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      TabButtonUI(
                        icon: Icons.wb_sunny_outlined,
                        isSelected: tabType == BottomBarType.today,
                        text: Loc.alized.today,
                        onTap: () => tabClick(BottomBarType.today),
                      ),
                      TabButtonUI(
                        icon: FontAwesomeIcons.map,
                        isSelected: tabType == BottomBarType.trip,
                        text: Loc.alized.trip_tab,
                        onTap: () => tabClick(BottomBarType.trip),
                      ),
                      // Slot under the raised Tanova button; only the label shows.
                      Expanded(
                        child: InkWell(
                          onTap: () => tabClick(BottomBarType.tanova),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 38),
                            child: Text(
                              Loc.alized.tanova,
                              textAlign: TextAlign.center,
                              style: TextStyles(context).description().copyWith(
                                color: tabType == BottomBarType.tanova
                                    ? AppTheme.goldTextColor
                                    : AppTheme.secondaryTextColor,
                                fontWeight: tabType == BottomBarType.tanova
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TabButtonUI(
                        icon: Icons.search,
                        isSelected: tabType == BottomBarType.explore,
                        text: Loc.alized.explore,
                        onTap: () => tabClick(BottomBarType.explore),
                      ),
                      TabButtonUI(
                        icon: FontAwesomeIcons.user,
                        isSelected: tabType == BottomBarType.you,
                        text: Loc.alized.you,
                        onTap: () => tabClick(BottomBarType.you),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Center(
                child: _TanovaButton(
                  active: tabType == BottomBarType.tanova,
                  onTap: () => tabClick(BottomBarType.tanova),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Tanova's raised centre button: champagne gold, the one place the accent is
/// used as a fill, ringed in the bar colour so it reads as breaking the bar.
class _TanovaButton extends StatelessWidget {
  const _TanovaButton({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: LuxColors.gold,
      shape: CircleBorder(
        side: BorderSide(color: AppTheme.backgroundColor, width: 4),
      ),
      elevation: active ? 0 : 2,
      shadowColor: LuxColors.charcoal.withValues(alpha: 0.25),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 58,
          height: 58,
          // Green on gold: white on champagne gold fails contrast.
          child: Icon(Icons.auto_awesome, color: LuxColors.green, size: 26),
        ),
      ),
    );
  }
}

enum BottomBarType { today, trip, tanova, explore, you }
