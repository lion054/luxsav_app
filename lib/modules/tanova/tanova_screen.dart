import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:luxsav_companion/constants/luxsav_brand.dart';
import 'package:luxsav_companion/constants/text_styles.dart';
import 'package:luxsav_companion/constants/themes.dart';
import 'package:luxsav_companion/language/app_localizations.dart';
import 'package:luxsav_companion/modules/tanova/tanova_controller.dart';
import 'package:luxsav_companion/widgets/bottom_top_move_animation_view.dart';
import 'package:luxsav_companion/widgets/common_button.dart';
import 'package:luxsav_companion/widgets/common_card.dart';

/// Tanova's planner. Ported from the `luxsav_app` scaffold and aligned to the
/// luxsav.com planner (see [TanovaController]).
class TanovaScreen extends StatefulWidget {
  final AnimationController animationController;

  const TanovaScreen({super.key, required this.animationController});

  @override
  State<TanovaScreen> createState() => _TanovaScreenState();
}

class _TanovaScreenState extends State<TanovaScreen> {
  final _search = TextEditingController();

  @override
  void initState() {
    Get.put(TanovaController(), permanent: true);
    widget.animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  String _windowLabel(DayWindow w) => switch (w.id) {
    'morning' => Loc.alized.morning_window,
    'afternoon' => Loc.alized.afternoon_window,
    _ => Loc.alized.full_day_window,
  };

  @override
  Widget build(BuildContext context) {
    return BottomTopMoveAnimationView(
      animationController: widget.animationController,
      child: GetBuilder<TanovaController>(
        builder: (c) => ListView(
          padding: EdgeInsets.fromLTRB(
            24,
            MediaQuery.of(context).padding.top + 16,
            24,
            32,
          ),
          children: [
            Text(
              Loc.alized.tanova.toUpperCase(),
              style: TextStyles(context).description().copyWith(
                fontSize: 12,
                letterSpacing: 1.8,
                fontWeight: FontWeight.w600,
                color: AppTheme.goldTextColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              Loc.alized.plan_your_trip,
              style: TextStyles(context).heading(),
            ),
            const SizedBox(height: 20),
            _TripTypeToggle(value: c.tripType, onChanged: c.setTripType),
            const SizedBox(height: 24),
            _label(context, Loc.alized.destination_label),
            _destinationSearch(context, c),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _travellers(context, c)),
                const SizedBox(width: 12),
                Expanded(child: _dates(context, c)),
              ],
            ),
            if (c.tripType == TripType.dayTrip) ...[
              const SizedBox(height: 24),
              _label(context, Loc.alized.time_of_day_label),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final w in TanovaController.dayWindows)
                    _Chip(
                      label: '${_windowLabel(w)}  ${w.start}–${w.end}',
                      selected: c.dayWindow?.id == w.id,
                      onTap: () => c.setDayWindow(w),
                    ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            _budget(context, c),
            const SizedBox(height: 28),
            Opacity(
              opacity: c.canBuild ? 1 : 0.45,
              child: CommonButton(
                buttonText: Loc.alized.build_itinerary,
                isClickable: c.canBuild,
                onTap: () => _showPlan(context, c),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(BuildContext context, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: TextStyles(context).bold().copyWith(fontSize: 15)),
  );

  Widget _destinationSearch(BuildContext context, TanovaController c) {
    final results = c.destinationResults;
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: LuxRadius.card,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextField(
              controller: _search,
              onChanged: c.search,
              style: TextStyles(context).regular(),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search, color: AppTheme.secondaryTextColor),
                hintText: Loc.alized.search_destination_hint,
                hintStyle: TextStyles(context).description(),
              ),
            ),
          ),
          Divider(height: 1, color: AppTheme.dividerColor),
          if (results.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                Loc.alized.no_destination_match,
                style: TextStyles(context).description(),
              ),
            ),
          for (final d in results)
            _DestinationRow(
              destination: d,
              selected: c.destination?['id'] == d['id'],
              onTap: () => c.pickDestination(d),
            ),
        ],
      ),
    );
  }

  Widget _travellers(BuildContext context, TanovaController c) {
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: LuxRadius.card,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Loc.alized.travellers_label,
              style: TextStyles(context).description().copyWith(fontSize: 13),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _StepButton(
                  icon: Icons.remove,
                  enabled: c.travellers > TanovaController.minTravellers,
                  onTap: () => c.setTravellers(c.travellers - 1),
                ),
                Expanded(
                  child: Text(
                    '${c.travellers}',
                    textAlign: TextAlign.center,
                    style: TextStyles(context).price(fontSize: 26),
                  ),
                ),
                _StepButton(
                  icon: Icons.add,
                  enabled: c.travellers < TanovaController.maxTravellers,
                  onTap: () => c.setTravellers(c.travellers + 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dates(BuildContext context, TanovaController c) {
    final fmt = DateFormat('d MMM');
    final String text;
    if (c.tripType == TripType.multiDay) {
      text = c.dateRange == null
          ? Loc.alized.choose_dates
          : '${fmt.format(c.dateRange!.start)} – ${fmt.format(c.dateRange!.end)}';
    } else {
      text = c.day == null
          ? Loc.alized.choose_day
          : DateFormat('EEE d MMM').format(c.day!);
    }
    return InkWell(
      borderRadius: BorderRadius.circular(LuxRadius.card),
      onTap: () => _pickDates(context, c),
      child: CommonCard(
        color: AppTheme.backgroundColor,
        radius: LuxRadius.card,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Loc.alized.dates_label,
                style: TextStyles(context).description().copyWith(fontSize: 13),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: AppTheme.secondaryTextColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles(context).regular().copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDates(BuildContext context, TanovaController c) async {
    final now = DateTime.now();
    final last = now.add(const Duration(days: 540));
    if (c.tripType == TripType.multiDay) {
      final picked = await showDateRangePicker(
        context: context,
        firstDate: now,
        lastDate: last,
        initialDateRange: c.dateRange,
      );
      if (picked != null) c.setDateRange(picked);
    } else {
      final picked = await showDatePicker(
        context: context,
        firstDate: now,
        lastDate: last,
        initialDate: c.day ?? now.add(const Duration(days: 7)),
      );
      if (picked != null) c.setDay(picked);
    }
  }

  Widget _budget(BuildContext context, TanovaController c) {
    final money = NumberFormat.currency(symbol: 'US\$', decimalDigits: 0);
    return CommonCard(
      color: AppTheme.backgroundColor,
      radius: LuxRadius.card,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    Loc.alized.budget_label,
                    style: TextStyles(context).bold().copyWith(fontSize: 15),
                  ),
                ),
                Text(
                  '${money.format(c.budget.start)} – ${money.format(c.budget.end)}',
                  style: TextStyles(context).price(fontSize: 22),
                ),
              ],
            ),
            Text(
              Loc.alized.budget_hint,
              style: TextStyles(context).description().copyWith(fontSize: 13),
            ),
            RangeSlider(
              values: c.budget,
              min: TanovaController.minBudget,
              max: TanovaController.maxBudget,
              divisions: 199,
              activeColor: AppTheme.primaryColor,
              inactiveColor: AppTheme.dividerColor,
              onChanged: c.setBudget,
            ),
          ],
        ),
      ),
    );
  }

  void _showPlan(BuildContext context, TanovaController c) {
    final request = c.platformRequest;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(LuxRadius.card),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Loc.alized.your_plan,
              style: TextStyles(context).heading(fontSize: 26),
            ),
            const SizedBox(height: 8),
            Text(
              Loc.alized.plan_preview_note,
              style: TextStyles(context).description().copyWith(fontSize: 14),
            ),
            const SizedBox(height: 16),
            for (final e in request.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 96,
                      child: Text(
                        e.key,
                        style: TextStyles(
                          context,
                        ).description().copyWith(fontSize: 13),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.value,
                        style: TextStyles(
                          context,
                        ).regular().copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TripTypeToggle extends StatelessWidget {
  const _TripTypeToggle({required this.value, required this.onChanged});

  final TripType value;
  final ValueChanged<TripType> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget option(TripType type, String label) {
      final selected = value == type;
      return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(LuxRadius.control),
          onTap: () => onChanged(type),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 11),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppTheme.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(LuxRadius.control),
            ),
            child: Text(
              label.toUpperCase(),
              style: TextStyles(context).regular().copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.6,
                color: selected
                    ? AppTheme.onPrimaryColor
                    : AppTheme.primaryTextColor,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.isLightMode ? LuxColors.cream : LuxColors.darkSurface,
        borderRadius: BorderRadius.circular(LuxRadius.control + 2),
      ),
      child: Row(
        children: [
          option(TripType.multiDay, Loc.alized.multi_day),
          option(TripType.dayTrip, Loc.alized.day_trip),
        ],
      ),
    );
  }
}

class _DestinationRow extends StatelessWidget {
  const _DestinationRow({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final Map<String, dynamic> destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(LuxRadius.small),
              child: Image.asset(
                destination['image'],
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${destination['name']}',
                    style: TextStyles(context).cardName(fontSize: 20),
                  ),
                  Text(
                    '${destination['country']} · ${Loc.alized.experiences_count(destination['experiences'] as int)}',
                    style: TextStyles(
                      context,
                    ).description().copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 22),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? AppTheme.primaryColor : AppTheme.dividerColor,
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled ? AppTheme.primaryColor : AppTheme.dividerColor,
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(LuxRadius.control),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryColor : AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(LuxRadius.control),
          border: Border.all(
            color: selected ? AppTheme.primaryColor : AppTheme.cardBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyles(context).regular().copyWith(
            fontSize: 14,
            color: selected
                ? AppTheme.onPrimaryColor
                : AppTheme.primaryTextColor,
          ),
        ),
      ),
    );
  }
}
