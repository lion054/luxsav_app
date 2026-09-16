import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luxsav_companion/constants/luxsav_brand.dart';
import 'package:luxsav_companion/constants/text_styles.dart';
import 'package:luxsav_companion/constants/themes.dart';
import 'package:luxsav_companion/data/luxsav_snapshot.dart';
import 'package:luxsav_companion/language/app_localizations.dart';
import 'package:luxsav_companion/models/hotel_list_data.dart';
import 'package:luxsav_companion/widgets/bottom_top_move_animation_view.dart';
import 'package:luxsav_companion/widgets/common_button.dart';

/// Today — the screen the app opens on.
///
/// This is the "no trip yet" state: it leads into Tanova rather than showing a
/// generic empty screen, then surfaces LuxSav experiences and destinations.
/// The upcoming and mid-trip states arrive with the trip model (merge plan
/// Step 2/3), which needs traveller accounts on luxsav.com.
class TodayScreen extends StatefulWidget {
  final AnimationController animationController;
  final VoidCallback onPlanTrip;

  const TodayScreen({
    super.key,
    required this.animationController,
    required this.onPlanTrip,
  });

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return Loc.alized.good_morning;
    if (h < 18) return Loc.alized.good_afternoon;
    return Loc.alized.good_evening;
  }

  @override
  Widget build(BuildContext context) {
    final experiences = HotelListData.hotelList
        .where((p) => p.priceUnitTxt == '/per person')
        .take(8)
        .toList();

    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: ListView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 16,
          bottom: 32,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat(
                    'EEEE d MMMM',
                  ).format(DateTime.now()).toUpperCase(),
                  style: TextStyles(context).description().copyWith(
                    fontSize: 12,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$_greeting, ${Loc.alized.amanda_text}',
                  style: TextStyles(context).heading(fontSize: 32),
                ),
                const SizedBox(height: 20),
                _planCard(context),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _sectionTitle(context, Loc.alized.best_deal),
          SizedBox(
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: experiences.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) =>
                  _ExperienceCard(item: experiences[i]),
            ),
          ),
          const SizedBox(height: 28),
          _sectionTitle(context, Loc.alized.popular_destination),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: LuxsavSnapshot.destinations.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) =>
                  _DestinationCard(destination: LuxsavSnapshot.destinations[i]),
            ),
          ),
        ],
      ),
    );
  }

  /// The Tanova prompt. Cream, as luxsav.com uses for feature sections, with a
  /// gold marker because it is a Tanova surface.
  Widget _planCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.isLightMode ? LuxColors.cream : LuxColors.darkSurface,
        borderRadius: BorderRadius.circular(LuxRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 16, color: AppTheme.goldTextColor),
              const SizedBox(width: 6),
              Text(
                Loc.alized.tanova.toUpperCase(),
                style: TextStyles(context).description().copyWith(
                  fontSize: 12,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.goldTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            Loc.alized.where_to_next,
            style: TextStyles(context).heading(fontSize: 28),
          ),
          const SizedBox(height: 6),
          Text(
            Loc.alized.ask_tanova_desc,
            style: TextStyles(context).regular().copyWith(
              fontSize: 15,
              color: AppTheme.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          CommonButton(
            buttonText: Loc.alized.start_planning,
            onTap: widget.onPlanTrip,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
    child: Text(text, style: TextStyles(context).heading(fontSize: 26)),
  );
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.item});

  final HotelListData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(LuxRadius.card),
        border: AppTheme.hairlineBorder,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item.imagePath,
            height: 130,
            width: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Text(
              item.titleTxt,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles(
                context,
              ).cardName(fontSize: 19).copyWith(height: 1.15),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '\$${item.perNight}',
                  style: TextStyles(context).price(fontSize: 20),
                ),
                const SizedBox(width: 4),
                Text(
                  item.priceUnitTxt ?? Loc.alized.per_night,
                  style: TextStyles(
                    context,
                  ).description().copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  const _DestinationCard({required this.destination});

  final Map<String, dynamic> destination;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(LuxRadius.card),
      child: SizedBox(
        width: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(destination['image'], fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    LuxColors.charcoal.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 10,
              child: Text(
                '${destination['name']}',
                style: TextStyles(
                  context,
                ).cardName(fontSize: 21).copyWith(color: LuxColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
