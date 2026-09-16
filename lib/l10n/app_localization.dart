import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_ar.dart';
import 'app_localization_en.dart';
import 'app_localization_fr.dart';
import 'app_localization_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
    Locale('ja'),
  ];

  /// No description provided for @best_hotel_deals.
  ///
  /// In en, this message translates to:
  /// **'The trip that looks after itself'**
  String get best_hotel_deals;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get already_have_account;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get get_started;

  /// No description provided for @plan_your_trips.
  ///
  /// In en, this message translates to:
  /// **'Plan with Tanova'**
  String get plan_your_trips;

  /// No description provided for @book_one_of_your.
  ///
  /// In en, this message translates to:
  /// **'Tell Tanova where, when and who’s coming,\nand it builds the whole trip around you'**
  String get book_one_of_your;

  /// No description provided for @find_best_deals.
  ///
  /// In en, this message translates to:
  /// **'Stays and experiences'**
  String get find_best_deals;

  /// No description provided for @find_deals_for_any.
  ///
  /// In en, this message translates to:
  /// **'Handpicked lodges, day trips and adventures,\nfrom Victoria Falls to Zanzibar'**
  String get find_deals_for_any;

  /// No description provided for @best_travelling_all_time.
  ///
  /// In en, this message translates to:
  /// **'Your trip, day by day'**
  String get best_travelling_all_time;

  /// No description provided for @trip_day_by_day_desc.
  ///
  /// In en, this message translates to:
  /// **'Every booking, voucher and pickup time\nin one place, even with no signal'**
  String get trip_day_by_day_desc;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get create_account;

  /// No description provided for @log_with_mail.
  ///
  /// In en, this message translates to:
  /// **'or log in with email'**
  String get log_with_mail;

  /// No description provided for @your_mail.
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get your_mail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_your_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgot_your_password;

  /// No description provided for @resend_email_link.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we’ll send you a link to reset your password'**
  String get resend_email_link;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get last_name;

  /// No description provided for @terms_agreed.
  ///
  /// In en, this message translates to:
  /// **'By signing up, you agree to our terms of\nservice and privacy policy'**
  String get terms_agreed;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @where_are_you_going.
  ///
  /// In en, this message translates to:
  /// **'Where would you like to go?'**
  String get where_are_you_going;

  /// No description provided for @search_hotel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_hotel;

  /// No description provided for @hotel_data.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotel_data;

  /// No description provided for @backpacker_data.
  ///
  /// In en, this message translates to:
  /// **'Backpackers'**
  String get backpacker_data;

  /// No description provided for @resort_data.
  ///
  /// In en, this message translates to:
  /// **'Resort'**
  String get resort_data;

  /// No description provided for @villa_data.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get villa_data;

  /// Stay type. Shown as "Lodge", which LuxSav sells; apartments are not offered.
  ///
  /// In en, this message translates to:
  /// **'Lodge'**
  String get apartment;

  /// No description provided for @guest_house.
  ///
  /// In en, this message translates to:
  /// **'Guest house'**
  String get guest_house;

  /// Stay type. LuxSav has no motels; this slot is shown as "Tented camp".
  ///
  /// In en, this message translates to:
  /// **'Tented camp'**
  String get motel;

  /// Stay type. Shown as "Cottage".
  ///
  /// In en, this message translates to:
  /// **'Cottage'**
  String get accommodation;

  /// No description provided for @bed_breakfast.
  ///
  /// In en, this message translates to:
  /// **'Bed & breakfast'**
  String get bed_breakfast;

  /// No description provided for @last_search.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get last_search;

  /// No description provided for @clear_all.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clear_all;

  /// No description provided for @cape_town.
  ///
  /// In en, this message translates to:
  /// **'Cape Town'**
  String get cape_town;

  /// No description provided for @five_star.
  ///
  /// In en, this message translates to:
  /// **'Handpicked experiences'**
  String get five_star;

  /// No description provided for @view_hotel.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get view_hotel;

  /// No description provided for @hotel_found.
  ///
  /// In en, this message translates to:
  /// **'results'**
  String get hotel_found;

  /// No description provided for @filtter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filtter;

  /// No description provided for @popular_destination.
  ///
  /// In en, this message translates to:
  /// **'Destinations'**
  String get popular_destination;

  /// No description provided for @best_deal.
  ///
  /// In en, this message translates to:
  /// **'Handpicked for you'**
  String get best_deal;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @km_to_city.
  ///
  /// In en, this message translates to:
  /// **'km to town centre'**
  String get km_to_city;

  /// No description provided for @per_night.
  ///
  /// In en, this message translates to:
  /// **'/per night'**
  String get per_night;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'reviews'**
  String get reviews;

  /// No description provided for @book_now.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get book_now;

  /// No description provided for @more_details.
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get more_details;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'read more'**
  String get read_more;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'less'**
  String get less;

  /// No description provided for @overall_rating.
  ///
  /// In en, this message translates to:
  /// **'Overall rating'**
  String get overall_rating;

  /// No description provided for @room.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get service;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @room_photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get room_photo;

  /// No description provided for @last_update.
  ///
  /// In en, this message translates to:
  /// **'Last Update'**
  String get last_update;

  /// No description provided for @reply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// No description provided for @my_trips.
  ///
  /// In en, this message translates to:
  /// **'My trips'**
  String get my_trips;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get favorites;

  /// No description provided for @price_text.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price_text;

  /// No description provided for @popular_filter.
  ///
  /// In en, this message translates to:
  /// **'Popular filters'**
  String get popular_filter;

  /// No description provided for @distance_from_city.
  ///
  /// In en, this message translates to:
  /// **'Distance from town centre'**
  String get distance_from_city;

  /// No description provided for @type_of_accommodation.
  ///
  /// In en, this message translates to:
  /// **'Type of stay'**
  String get type_of_accommodation;

  /// No description provided for @apply_text.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply_text;

  /// No description provided for @all_text.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_text;

  /// No description provided for @home_text.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_text;

  /// No description provided for @free_breakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast included'**
  String get free_breakfast;

  /// No description provided for @free_Parking.
  ///
  /// In en, this message translates to:
  /// **'Free parking'**
  String get free_Parking;

  /// No description provided for @pool_text.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get pool_text;

  /// No description provided for @pet_friendlly.
  ///
  /// In en, this message translates to:
  /// **'Pet friendly'**
  String get pet_friendlly;

  /// No description provided for @free_wifi.
  ///
  /// In en, this message translates to:
  /// **'Free Wi-Fi'**
  String get free_wifi;

  /// No description provided for @less_than.
  ///
  /// In en, this message translates to:
  /// **'Less than'**
  String get less_than;

  /// No description provided for @km_text.
  ///
  /// In en, this message translates to:
  /// **'Km'**
  String get km_text;

  /// No description provided for @amanda_text.
  ///
  /// In en, this message translates to:
  /// **'Amanda'**
  String get amanda_text;

  /// No description provided for @view_edit.
  ///
  /// In en, this message translates to:
  /// **'View and edit profile'**
  String get view_edit;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get edit_profile;

  /// No description provided for @username_text.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username_text;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get date_of_birth;

  /// No description provided for @address_text.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address_text;

  /// No description provided for @mail_text.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get mail_text;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get change_password;

  /// No description provided for @enter_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password and confirm your password'**
  String get enter_your_new_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get new_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password;

  /// No description provided for @invite_friend.
  ///
  /// In en, this message translates to:
  /// **'Invite a friend'**
  String get invite_friend;

  /// No description provided for @invite_your_friend.
  ///
  /// In en, this message translates to:
  /// **'Invite a friend'**
  String get invite_your_friend;

  /// No description provided for @invite_friend_desc.
  ///
  /// In en, this message translates to:
  /// **'Share LuxSav with someone planning their next trip'**
  String get invite_friend_desc;

  /// No description provided for @share_text.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share_text;

  /// No description provided for @credit_coupons.
  ///
  /// In en, this message translates to:
  /// **'Credit & coupons'**
  String get credit_coupons;

  /// No description provided for @help_center.
  ///
  /// In en, this message translates to:
  /// **'Help centre'**
  String get help_center;

  /// No description provided for @how_can_help_you.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get how_can_help_you;

  /// No description provided for @search_help_artical.
  ///
  /// In en, this message translates to:
  /// **'Search help articles'**
  String get search_help_artical;

  /// No description provided for @paying_for_a_reservation.
  ///
  /// In en, this message translates to:
  /// **'Paying for a booking'**
  String get paying_for_a_reservation;

  /// No description provided for @trust_and_safety.
  ///
  /// In en, this message translates to:
  /// **'Trust and safety'**
  String get trust_and_safety;

  /// No description provided for @how_do_i.
  ///
  /// In en, this message translates to:
  /// **'How do I cancel a booking?'**
  String get how_do_i;

  /// No description provided for @what_methods.
  ///
  /// In en, this message translates to:
  /// **'Which payment methods does LuxSav accept?'**
  String get what_methods;

  /// No description provided for @i_m_a_guest_what.
  ///
  /// In en, this message translates to:
  /// **'I’m travelling. What safety tips should I follow?'**
  String get i_m_a_guest_what;

  /// No description provided for @when_am_i_charged.
  ///
  /// In en, this message translates to:
  /// **'When am I charged for a booking?'**
  String get when_am_i_charged;

  /// No description provided for @how_do_i_edit.
  ///
  /// In en, this message translates to:
  /// **'How do I edit or remove a payment method?'**
  String get how_do_i_edit;

  /// No description provided for @you_can_cancel.
  ///
  /// In en, this message translates to:
  /// **'You can cancel a booking before or during your trip. To cancel:'**
  String get you_can_cancel;

  /// No description provided for @go_to_trips_and_choose_yotr_trip.
  ///
  /// In en, this message translates to:
  /// **'Go to Trips, choose your trip, then choose the booking you want to cancel.'**
  String get go_to_trips_and_choose_yotr_trip;

  /// No description provided for @you_be_taken_to.
  ///
  /// In en, this message translates to:
  /// **'You’ll see the options to change or cancel it. Choose cancel to start the cancellation.'**
  String get you_be_taken_to;

  /// No description provided for @if_you_cancel_your.
  ///
  /// In en, this message translates to:
  /// **'Your refund depends on the supplier’s cancellation policy. We’ll show you the refund before you confirm.'**
  String get if_you_cancel_your;

  /// No description provided for @give_feedback.
  ///
  /// In en, this message translates to:
  /// **'Give feedback'**
  String get give_feedback;

  /// No description provided for @related_articles.
  ///
  /// In en, this message translates to:
  /// **'Related articles'**
  String get related_articles;

  /// No description provided for @can_i_change.
  ///
  /// In en, this message translates to:
  /// **'Can I change a booking?'**
  String get can_i_change;

  /// No description provided for @how_do_i_cancel.
  ///
  /// In en, this message translates to:
  /// **'How do I cancel a booking request?'**
  String get how_do_i_cancel;

  /// No description provided for @what_is_the.
  ///
  /// In en, this message translates to:
  /// **'How do I reach the LuxSav team?'**
  String get what_is_the;

  /// No description provided for @payment_text.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment_text;

  /// No description provided for @setting_text.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting_text;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @theme_mode.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get theme_mode;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @fonts.
  ///
  /// In en, this message translates to:
  /// **'Fonts'**
  String get fonts;

  /// No description provided for @selected_fonts.
  ///
  /// In en, this message translates to:
  /// **'Selected fonts'**
  String get selected_fonts;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @selected_color.
  ///
  /// In en, this message translates to:
  /// **'Selected color'**
  String get selected_color;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selected_language.
  ///
  /// In en, this message translates to:
  /// **'Selected language'**
  String get selected_language;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @terms_of_services.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get terms_of_services;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @give_us_feedbacks.
  ///
  /// In en, this message translates to:
  /// **'Give us feedback'**
  String get give_us_feedbacks;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @room_selected.
  ///
  /// In en, this message translates to:
  /// **'Room selected'**
  String get room_selected;

  /// No description provided for @number_room.
  ///
  /// In en, this message translates to:
  /// **'Rooms & guests'**
  String get number_room;

  /// No description provided for @people_data.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get people_data;

  /// No description provided for @room_data.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room_data;

  /// No description provided for @choose_date.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get choose_date;

  /// No description provided for @apply_date.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply_date;

  /// No description provided for @from_text.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from_text;

  /// No description provided for @to_text.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to_text;

  /// No description provided for @sleeps.
  ///
  /// In en, this message translates to:
  /// **'sleeps'**
  String get sleeps;

  /// No description provided for @children.
  ///
  /// In en, this message translates to:
  /// **'children'**
  String get children;

  /// No description provided for @enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'enter new password'**
  String get enter_new_password;

  /// No description provided for @enter_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'confirm password'**
  String get enter_confirm_password;

  /// No description provided for @password_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get password_cannot_empty;

  /// No description provided for @valid_new_password.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be at least 6 characters.'**
  String get valid_new_password;

  /// No description provided for @valid_password.
  ///
  /// In en, this message translates to:
  /// **'Your password must be at least 6 characters.'**
  String get valid_password;

  /// No description provided for @password_not_match.
  ///
  /// In en, this message translates to:
  /// **'The passwords don’t match.'**
  String get password_not_match;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'enter your email'**
  String get enter_your_email;

  /// No description provided for @email_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get email_cannot_empty;

  /// No description provided for @enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address, e.g. name@example.com'**
  String get enter_valid_email;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'enter password'**
  String get enter_password;

  /// No description provided for @enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get enter_first_name;

  /// No description provided for @enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get enter_last_name;

  /// No description provided for @first_name_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'First Name cannot be empty'**
  String get first_name_cannot_empty;

  /// No description provided for @last_name_cannot_empty.
  ///
  /// In en, this message translates to:
  /// **'Last Name cannot be empty'**
  String get last_name_cannot_empty;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @trip_tab.
  ///
  /// In en, this message translates to:
  /// **'Trip'**
  String get trip_tab;

  /// No description provided for @tanova.
  ///
  /// In en, this message translates to:
  /// **'Tanova'**
  String get tanova;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get good_morning;

  /// No description provided for @good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get good_afternoon;

  /// No description provided for @good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get good_evening;

  /// No description provided for @where_to_next.
  ///
  /// In en, this message translates to:
  /// **'Where to next?'**
  String get where_to_next;

  /// No description provided for @ask_tanova_desc.
  ///
  /// In en, this message translates to:
  /// **'Tell Tanova where, when and who’s coming, and it builds the whole trip around you.'**
  String get ask_tanova_desc;

  /// No description provided for @start_planning.
  ///
  /// In en, this message translates to:
  /// **'Start planning'**
  String get start_planning;

  /// No description provided for @plan_your_trip.
  ///
  /// In en, this message translates to:
  /// **'Plan your trip'**
  String get plan_your_trip;

  /// No description provided for @multi_day.
  ///
  /// In en, this message translates to:
  /// **'Multi-day'**
  String get multi_day;

  /// No description provided for @day_trip.
  ///
  /// In en, this message translates to:
  /// **'Day trip'**
  String get day_trip;

  /// No description provided for @destination_label.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination_label;

  /// No description provided for @search_destination_hint.
  ///
  /// In en, this message translates to:
  /// **'Search a destination'**
  String get search_destination_hint;

  /// No description provided for @no_destination_match.
  ///
  /// In en, this message translates to:
  /// **'No LuxSav destination matches that search.'**
  String get no_destination_match;

  /// No description provided for @travellers_label.
  ///
  /// In en, this message translates to:
  /// **'Travellers'**
  String get travellers_label;

  /// No description provided for @dates_label.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get dates_label;

  /// No description provided for @choose_dates.
  ///
  /// In en, this message translates to:
  /// **'Choose dates'**
  String get choose_dates;

  /// No description provided for @choose_day.
  ///
  /// In en, this message translates to:
  /// **'Choose a day'**
  String get choose_day;

  /// No description provided for @time_of_day_label.
  ///
  /// In en, this message translates to:
  /// **'Time of day'**
  String get time_of_day_label;

  /// No description provided for @morning_window.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning_window;

  /// No description provided for @afternoon_window.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get afternoon_window;

  /// No description provided for @full_day_window.
  ///
  /// In en, this message translates to:
  /// **'Full day'**
  String get full_day_window;

  /// No description provided for @budget_label.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget_label;

  /// No description provided for @budget_hint.
  ///
  /// In en, this message translates to:
  /// **'Total for your whole party'**
  String get budget_hint;

  /// No description provided for @build_itinerary.
  ///
  /// In en, this message translates to:
  /// **'Build my itinerary'**
  String get build_itinerary;

  /// No description provided for @your_plan.
  ///
  /// In en, this message translates to:
  /// **'Your plan'**
  String get your_plan;

  /// No description provided for @plan_preview_note.
  ///
  /// In en, this message translates to:
  /// **'This preview isn’t connected to luxsav.com yet. Once it is, Tanova sends exactly this request and returns your itinerary options.'**
  String get plan_preview_note;

  /// No description provided for @experiences_count.
  ///
  /// In en, this message translates to:
  /// **'{count} experiences'**
  String experiences_count(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
