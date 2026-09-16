import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luxsav_companion/models/hotel_list_data.dart';

/// Real LuxSav content for design builds.
///
/// Reads `assets/fixtures/luxsav_snapshot.json` (captured from luxsav.com by
/// `tool/snapshot/capture.py`) and feeds it into the kit's existing lists, so
/// the screens show LuxSav destinations, stays and experiences instead of the
/// kit's London hotels.
///
/// This is a temporary adapter: it keeps the kit's `HotelListData` shape and
/// borrows presentation-only fields (dates, sample ratings, room counts) from
/// the kit's samples. Merge plan Step 3 replaces the model; Step 4 replaces
/// the snapshot with the live API.
class LuxsavSnapshot {
  LuxsavSnapshot._();

  static const _asset = 'assets/fixtures/luxsav_snapshot.json';

  /// Destination centres. The platform stores no coordinates yet, so map pins
  /// are placed around the destination with a small offset. Placeholder only.
  static const Map<String, LatLng> _destinationCentres = {
    'Victoria Falls': LatLng(-17.9243, 25.8572),
    'Inyanga': LatLng(-18.2167, 32.7500),
    'Harare': LatLng(-17.8252, 31.0335),
    'Capetown': LatLng(-33.9249, 18.4241),
    'Dubai': LatLng(25.2048, 55.2708),
    'Singapore': LatLng(1.3521, 103.8198),
    'Zanzibar': LatLng(-6.1659, 39.2026),
  };

  /// The centre the map opens on — LuxSav's pilot destination.
  static const LatLng pilotDestination = LatLng(-17.9243, 25.8572);

  static List<Map<String, dynamic>> destinations = [];

  static Future<void> load() async {
    final Map<String, dynamic> data = jsonDecode(
      await rootBundle.loadString(_asset),
    );

    destinations = List<Map<String, dynamic>>.from(data['destinations']);
    final stays = List<Map<String, dynamic>>.from(data['stays']);
    final experiences = List<Map<String, dynamic>>.from(data['experiences']);

    final kitHotels = List<HotelListData>.from(HotelListData.hotelList);
    final kitSearches = List<HotelListData>.from(
      HotelListData.lastsSearchesList,
    );

    // Alternate stays and experiences so both kinds of product appear on
    // every list screen.
    final products = <Map<String, dynamic>>[];
    for (var i = 0; i < stays.length || i < experiences.length; i++) {
      if (i < stays.length) products.add(stays[i]);
      if (i < experiences.length) products.add(experiences[i]);
    }

    HotelListData.hotelList = [
      for (var i = 0; i < products.length; i++)
        _product(products[i], kitHotels[i % kitHotels.length], i),
    ];

    HotelListData.popularList = [
      for (final d in destinations)
        HotelListData(imagePath: d['image'], titleTxt: d['name']),
    ];

    HotelListData.lastsSearchesList = [
      for (var i = 0; i < destinations.length; i++)
        _copyPresentation(
          kitSearches[i % kitSearches.length],
          imagePath: destinations[i]['image'],
          titleTxt: destinations[i]['name'],
          subTxt: destinations[i]['country'],
        ),
    ];
  }

  static HotelListData _product(
    Map<String, dynamic> p,
    HotelListData sample,
    int index,
  ) {
    final centre = _destinationCentres[p['destination']] ?? pilotDestination;
    // Spread pins in a small ring so they don't stack on one point.
    final offset = 0.006 * ((index % 5) - 2);
    return _copyPresentation(
      sample,
      imagePath: p['image'],
      titleTxt: p['name'],
      subTxt: '${p['destination']}, ${p['country']}',
      perNight: p['price'] as int,
      priceUnitTxt: '/${p['price_unit']}',
      location: LatLng(centre.latitude + offset, centre.longitude - offset),
    );
  }

  static HotelListData _copyPresentation(
    HotelListData s, {
    required String imagePath,
    required String titleTxt,
    required String subTxt,
    int? perNight,
    String? priceUnitTxt,
    LatLng? location,
  }) {
    return HotelListData(
      imagePath: imagePath,
      titleTxt: titleTxt,
      subTxt: subTxt,
      perNight: perNight ?? s.perNight,
      priceUnitTxt: priceUnitTxt,
      location: location ?? s.location,
      // Presentation-only sample fields, kept from the kit for now.
      date: s.date,
      dateTxt: s.dateTxt,
      roomSizeTxt: s.roomSizeTxt,
      roomData: s.roomData,
      dist: s.dist,
      rating: s.rating,
      reviews: s.reviews,
      isSelected: s.isSelected,
      peopleSleeps: s.peopleSleeps,
    );
  }
}
