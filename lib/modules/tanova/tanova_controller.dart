import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:luxsav_companion/data/luxsav_snapshot.dart';

enum TripType { multiDay, dayTrip }

/// A day-trip time window, matching the luxsav.com planner's options.
class DayWindow {
  final String id;
  final String start;
  final String end;
  const DayWindow(this.id, this.start, this.end);
}

/// State for Tanova's planning form.
///
/// Mirrors the luxsav.com planner so both send the same request:
/// trip type first, a LuxSav destination, 1–7 travellers, a budget for the
/// whole party, then a date range (multi-day) or one day plus a time window
/// (day trip). Ported from `luxsav_app` (Riverpod) to GetX.
class TanovaController extends GetxController {
  /// The luxsav.com planner caps parties at 7.
  static const int minTravellers = 1;
  static const int maxTravellers = 7;

  /// luxsav.com rejects budgets under US$100.
  static const double minBudget = 100;
  static const double maxBudget = 20000;

  /// Same windows as the website's day-trip chips.
  static const List<DayWindow> dayWindows = [
    DayWindow('morning', '07:00', '13:00'),
    DayWindow('afternoon', '12:00', '18:00'),
    DayWindow('full_day', '07:00', '19:00'),
  ];

  TripType tripType = TripType.multiDay;
  Map<String, dynamic>? destination;
  String query = '';
  int travellers = 2;
  RangeValues budget = const RangeValues(500, 3000);
  DateTimeRange? dateRange;
  DateTime? day;
  DayWindow? dayWindow;

  List<Map<String, dynamic>> get destinationResults {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return LuxsavSnapshot.destinations;
    return LuxsavSnapshot.destinations
        .where(
          (d) =>
              '${d['name']}'.toLowerCase().contains(q) ||
              '${d['country']}'.toLowerCase().contains(q),
        )
        .toList();
  }

  bool get hasDates => tripType == TripType.multiDay
      ? dateRange != null
      : day != null && dayWindow != null;

  bool get canBuild => destination != null && hasDates;

  void setTripType(TripType type) {
    tripType = type;
    update();
  }

  void search(String value) {
    query = value;
    update();
  }

  void pickDestination(Map<String, dynamic> d) {
    destination = d;
    update();
  }

  void setTravellers(int value) {
    travellers = value.clamp(minTravellers, maxTravellers);
    update();
  }

  void setBudget(RangeValues value) {
    budget = value;
    update();
  }

  void setDateRange(DateTimeRange range) {
    dateRange = range;
    update();
  }

  void setDay(DateTime value) {
    day = value;
    update();
  }

  void setDayWindow(DayWindow window) {
    dayWindow = window;
    update();
  }

  static final _platformDate = DateFormat('MM/dd/yyyy');

  /// The request luxsav.com expects, in its own field names and formats.
  /// Budget is a single total on the platform, so the top of the range is sent.
  Map<String, String> get platformRequest {
    final d = destination!;
    if (tripType == TripType.multiDay) {
      return {
        'endpoint': 'POST /results',
        'place_id': '${d['id']}',
        'place_name': '${d['name']}, ${d['country']}',
        'daterange':
            '${_platformDate.format(dateRange!.start)} - ${_platformDate.format(dateRange!.end)}',
        'max_pax': '$travellers',
        'budget': budget.end.round().toString(),
      };
    }
    return {
      'endpoint': 'GET /daytrips',
      'q': '${d['name']}',
      'pax': '$travellers',
      'budget': budget.end.round().toString(),
      'date': _platformDate.format(day!),
      'start': dayWindow!.start,
      'end': dayWindow!.end,
    };
  }
}
