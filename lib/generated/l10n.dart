// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign in`
  String get login {
    return Intl.message(
      'Sign in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Invalid user name`
  String get usernamevalidation {
    return Intl.message(
      'Invalid user name',
      name: 'usernamevalidation',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get emailvalidation {
    return Intl.message(
      'Invalid email',
      name: 'emailvalidation',
      desc: '',
      args: [],
    );
  }

  /// `ُInvalid phone number`
  String get phonevalidation {
    return Intl.message(
      'ُInvalid phone number',
      name: 'phonevalidation',
      desc: '',
      args: [],
    );
  }

  /// `Value can't be less than`
  String get minvaluevalidation {
    return Intl.message(
      'Value can\'t be less than',
      name: 'minvaluevalidation',
      desc: '',
      args: [],
    );
  }

  /// `Value can't be more than`
  String get maxvaluevalidation {
    return Intl.message(
      'Value can\'t be more than',
      name: 'maxvaluevalidation',
      desc: '',
      args: [],
    );
  }

  /// `Value can't be empty`
  String get emptyvalidation {
    return Intl.message(
      'Value can\'t be empty',
      name: 'emptyvalidation',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailaddres {
    return Intl.message(
      'Email',
      name: 'emailaddres',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgetpassword {
    return Intl.message(
      'Forgot password',
      name: 'forgetpassword',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get create_an_account {
    return Intl.message(
      'Create an account',
      name: 'create_an_account',
      desc: '',
      args: [],
    );
  }

  /// `By continuing you agree to End`
  String get By_continuing_you_agree_to_End {
    return Intl.message(
      'By continuing you agree to End',
      name: 'By_continuing_you_agree_to_End',
      desc: '',
      args: [],
    );
  }

  /// `User license agreement`
  String get user_license_agreement {
    return Intl.message(
      'User license agreement',
      name: 'user_license_agreement',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get Privacy_policy {
    return Intl.message(
      'Privacy policy',
      name: 'Privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Ready to start saving`
  String get ready_to_start_saving {
    return Intl.message(
      'Ready to start saving',
      name: 'ready_to_start_saving',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get Privacy {
    return Intl.message(
      'Privacy',
      name: 'Privacy',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Join us`
  String get join_us {
    return Intl.message(
      'Join us',
      name: 'join_us',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmpassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmpassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address to reset your`
  String get enter_your_email_addres_to_reset_your {
    return Intl.message(
      'Enter your email address to reset your',
      name: 'enter_your_email_addres_to_reset_your',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `Back to`
  String get back_to {
    return Intl.message(
      'Back to',
      name: 'back_to',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginpage {
    return Intl.message(
      'Login',
      name: 'loginpage',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Skip {
    return Intl.message(
      'Skip',
      name: 'Skip',
      desc: '',
      args: [],
    );
  }

  /// `?`
  String get question {
    return Intl.message(
      '?',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Back {
    return Intl.message(
      'Back',
      name: 'Back',
      desc: '',
      args: [],
    );
  }

  /// `We've Sent the Verification code to`
  String get we_have_Sent_the_Verification_code_to {
    return Intl.message(
      'We\'ve Sent the Verification code to',
      name: 'we_have_Sent_the_Verification_code_to',
      desc: '',
      args: [],
    );
  }

  /// `Via whatsapp`
  String get via_whatsapp {
    return Intl.message(
      'Via whatsapp',
      name: 'via_whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enter_OTP {
    return Intl.message(
      'Enter OTP',
      name: 'enter_OTP',
      desc: '',
      args: [],
    );
  }

  /// `Don't received OTP code yet`
  String get dont_received_OTP_code_yet {
    return Intl.message(
      'Don\'t received OTP code yet',
      name: 'dont_received_OTP_code_yet',
      desc: '',
      args: [],
    );
  }

  /// `ٌReset`
  String get reset {
    return Intl.message(
      'ٌReset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Our News`
  String get our_new {
    return Intl.message(
      'Our News',
      name: 'our_new',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get see_all {
    return Intl.message(
      'See all',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Best Seller`
  String get best_seller {
    return Intl.message(
      'Best Seller',
      name: 'best_seller',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get add_to_card {
    return Intl.message(
      'Add To Cart',
      name: 'add_to_card',
      desc: '',
      args: [],
    );
  }

  /// `View Coupons`
  String get view_coupons {
    return Intl.message(
      'View Coupons',
      name: 'view_coupons',
      desc: '',
      args: [],
    );
  }

  /// `Locations`
  String get location {
    return Intl.message(
      'Locations',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get terms {
    return Intl.message(
      'Terms',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `Before Price`
  String get beforprice {
    return Intl.message(
      'Before Price',
      name: 'beforprice',
      desc: '',
      args: [],
    );
  }

  /// `Main Branch`
  String get main_branch {
    return Intl.message(
      'Main Branch',
      name: 'main_branch',
      desc: '',
      args: [],
    );
  }

  /// `Use Offer`
  String get useoffer {
    return Intl.message(
      'Use Offer',
      name: 'useoffer',
      desc: '',
      args: [],
    );
  }

  /// `View Offers`
  String get view_offers {
    return Intl.message(
      'View Offers',
      name: 'view_offers',
      desc: '',
      args: [],
    );
  }

  /// ` Please show this Qr to the cachier`
  String get please_show_this_page_to_the_cachier {
    return Intl.message(
      ' Please show this Qr to the cachier',
      name: 'please_show_this_page_to_the_cachier',
      desc: '',
      args: [],
    );
  }

  /// `Points will consumed from your points`
  String get points_will_consumed_from_your_points {
    return Intl.message(
      'Points will consumed from your points',
      name: 'points_will_consumed_from_your_points',
      desc: '',
      args: [],
    );
  }

  /// `Your balance of points is`
  String get your_balance_of_points_is {
    return Intl.message(
      'Your balance of points is',
      name: 'your_balance_of_points_is',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `and you can not use this offer`
  String get and_you_can_not_use_this_offer {
    return Intl.message(
      'and you can not use this offer',
      name: 'and_you_can_not_use_this_offer',
      desc: '',
      args: [],
    );
  }

  /// `ُEdit your personl information`
  String get edit_your_profile_information {
    return Intl.message(
      'ُEdit your personl information',
      name: 'edit_your_profile_information',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get old_password {
    return Intl.message(
      'Old Password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Buy Points`
  String get buy_points {
    return Intl.message(
      'Buy Points',
      name: 'buy_points',
      desc: '',
      args: [],
    );
  }

  /// `Buy Coupon`
  String get buy_coupon {
    return Intl.message(
      'Buy Coupon',
      name: 'buy_coupon',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `S.R`
  String get S_R {
    return Intl.message(
      'S.R',
      name: 'S_R',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `Coupons`
  String get coupons {
    return Intl.message(
      'Coupons',
      name: 'coupons',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Order`
  String get confirm_order {
    return Intl.message(
      'Confirm Order',
      name: 'confirm_order',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get order_summary {
    return Intl.message(
      'Order Summary',
      name: 'order_summary',
      desc: '',
      args: [],
    );
  }

  /// `Promo Code`
  String get promo_code {
    return Intl.message(
      'Promo Code',
      name: 'promo_code',
      desc: '',
      args: [],
    );
  }

  /// `Apply Promo Code`
  String get apply_promo_code {
    return Intl.message(
      'Apply Promo Code',
      name: 'apply_promo_code',
      desc: '',
      args: [],
    );
  }

  /// `ُEnter Promo Code`
  String get enter_promo_code {
    return Intl.message(
      'ُEnter Promo Code',
      name: 'enter_promo_code',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Apply Code`
  String get apply_code {
    return Intl.message(
      'Apply Code',
      name: 'apply_code',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `SubTotal`
  String get sub_total {
    return Intl.message(
      'SubTotal',
      name: 'sub_total',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart`
  String get your_card {
    return Intl.message(
      'Your Cart',
      name: 'your_card',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sort_by {
    return Intl.message(
      'Sort by',
      name: 'sort_by',
      desc: '',
      args: [],
    );
  }

  /// `Default Sorting`
  String get default_sorting {
    return Intl.message(
      'Default Sorting',
      name: 'default_sorting',
      desc: '',
      args: [],
    );
  }

  /// `Newest Arrivals`
  String get newest_arrivals {
    return Intl.message(
      'Newest Arrivals',
      name: 'newest_arrivals',
      desc: '',
      args: [],
    );
  }

  /// `Customers Review`
  String get customers_review {
    return Intl.message(
      'Customers Review',
      name: 'customers_review',
      desc: '',
      args: [],
    );
  }

  /// `By Price: Low to high`
  String get by_price_low_to_high {
    return Intl.message(
      'By Price: Low to high',
      name: 'by_price_low_to_high',
      desc: '',
      args: [],
    );
  }

  /// `By Price: high to Low`
  String get by_price_high_to_low {
    return Intl.message(
      'By Price: high to Low',
      name: 'by_price_high_to_low',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Type here to search`
  String get search_for_product {
    return Intl.message(
      'Type here to search',
      name: 'search_for_product',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get category {
    return Intl.message(
      'Categories',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Price Range`
  String get price_range {
    return Intl.message(
      'Price Range',
      name: 'price_range',
      desc: '',
      args: [],
    );
  }

  /// `Reset Filtter`
  String get reset_filtter {
    return Intl.message(
      'Reset Filtter',
      name: 'reset_filtter',
      desc: '',
      args: [],
    );
  }

  /// `Apply Filtter`
  String get apply_filtter {
    return Intl.message(
      'Apply Filtter',
      name: 'apply_filtter',
      desc: '',
      args: [],
    );
  }

  /// `What are you looking for`
  String get what_are_you_looking_for {
    return Intl.message(
      'What are you looking for',
      name: 'what_are_you_looking_for',
      desc: '',
      args: [],
    );
  }

  /// `Select one`
  String get selectone {
    return Intl.message(
      'Select one',
      name: 'selectone',
      desc: '',
      args: [],
    );
  }

  /// `Providers`
  String get providers {
    return Intl.message(
      'Providers',
      name: 'providers',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Select Your City`
  String get select_your_city {
    return Intl.message(
      'Select Your City',
      name: 'select_your_city',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `Internet connection error`
  String get Internet_connection_error {
    return Intl.message(
      'Internet connection error',
      name: 'Internet_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `&`
  String get and {
    return Intl.message(
      '&',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get about_app {
    return Intl.message(
      'About App',
      name: 'about_app',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `More Deals`
  String get moredeals {
    return Intl.message(
      'More Deals',
      name: 'moredeals',
      desc: '',
      args: [],
    );
  }

  /// `Similar Deals`
  String get similardeals {
    return Intl.message(
      'Similar Deals',
      name: 'similardeals',
      desc: '',
      args: [],
    );
  }

  /// `Needed Login`
  String get needed_login {
    return Intl.message(
      'Needed Login',
      name: 'needed_login',
      desc: '',
      args: [],
    );
  }

  /// `Please Login To Complete`
  String get please_login_complete {
    return Intl.message(
      'Please Login To Complete',
      name: 'please_login_complete',
      desc: '',
      args: [],
    );
  }

  /// `Go To Cart`
  String get go_to_cart {
    return Intl.message(
      'Go To Cart',
      name: 'go_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continue_shopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continue_shopping',
      desc: '',
      args: [],
    );
  }

  /// ` My Profile`
  String get profile {
    return Intl.message(
      ' My Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `My Coupons`
  String get my_coupons {
    return Intl.message(
      'My Coupons',
      name: 'my_coupons',
      desc: '',
      args: [],
    );
  }

  /// `History Points`
  String get history_points {
    return Intl.message(
      'History Points',
      name: 'history_points',
      desc: '',
      args: [],
    );
  }

  /// `My Purchases`
  String get my_purchases {
    return Intl.message(
      'My Purchases',
      name: 'my_purchases',
      desc: '',
      args: [],
    );
  }

  /// `Points Wallet`
  String get points_wallet {
    return Intl.message(
      'Points Wallet',
      name: 'points_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Join Invitations`
  String get join_invitations {
    return Intl.message(
      'Join Invitations',
      name: 'join_invitations',
      desc: '',
      args: [],
    );
  }

  /// `Whishlist`
  String get WhishList {
    return Intl.message(
      'Whishlist',
      name: 'WhishList',
      desc: '',
      args: [],
    );
  }

  /// `Edit Information`
  String get edit_informations {
    return Intl.message(
      'Edit Information',
      name: 'edit_informations',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get Upgrade {
    return Intl.message(
      'Upgrade',
      name: 'Upgrade',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Invitation`
  String get invitation {
    return Intl.message(
      'Invitation',
      name: 'invitation',
      desc: '',
      args: [],
    );
  }

  /// `Copy invitation link`
  String get Copy_invitation_link {
    return Intl.message(
      'Copy invitation link',
      name: 'Copy_invitation_link',
      desc: '',
      args: [],
    );
  }

  /// `Link Coppied successfully`
  String get link_copied_successfully {
    return Intl.message(
      'Link Coppied successfully',
      name: 'link_copied_successfully',
      desc: '',
      args: [],
    );
  }

  /// `View all notifications`
  String get view_all_notifications {
    return Intl.message(
      'View all notifications',
      name: 'view_all_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Pacakage`
  String get Subscription_Pacakage {
    return Intl.message(
      'Subscription Pacakage',
      name: 'Subscription_Pacakage',
      desc: '',
      args: [],
    );
  }

  /// `Send Voucher On WhatsApp`
  String get send_voucher_on_whatsapp {
    return Intl.message(
      'Send Voucher On WhatsApp',
      name: 'send_voucher_on_whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your WhatsApp Number`
  String get enter_your_whatsapp_number {
    return Intl.message(
      'Enter Your WhatsApp Number',
      name: 'enter_your_whatsapp_number',
      desc: '',
      args: [],
    );
  }

  /// `Valid to`
  String get valid_to {
    return Intl.message(
      'Valid to',
      name: 'valid_to',
      desc: '',
      args: [],
    );
  }

  /// `Flash Deals`
  String get flashdeals {
    return Intl.message(
      'Flash Deals',
      name: 'flashdeals',
      desc: '',
      args: [],
    );
  }

  /// `Order Information`
  String get order_information {
    return Intl.message(
      'Order Information',
      name: 'order_information',
      desc: '',
      args: [],
    );
  }

  /// `Order Ref`
  String get order_ref {
    return Intl.message(
      'Order Ref',
      name: 'order_ref',
      desc: '',
      args: [],
    );
  }

  /// `Order Date`
  String get order_date {
    return Intl.message(
      'Order Date',
      name: 'order_date',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Order name`
  String get order_name {
    return Intl.message(
      'Order name',
      name: 'order_name',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Payment Info`
  String get payment_info {
    return Intl.message(
      'Payment Info',
      name: 'payment_info',
      desc: '',
      args: [],
    );
  }

  /// `Payment Date`
  String get payment_date {
    return Intl.message(
      'Payment Date',
      name: 'payment_date',
      desc: '',
      args: [],
    );
  }

  /// `Payment Referance`
  String get payment_referance {
    return Intl.message(
      'Payment Referance',
      name: 'payment_referance',
      desc: '',
      args: [],
    );
  }

  /// `Payment Amount`
  String get payment_amount {
    return Intl.message(
      'Payment Amount',
      name: 'payment_amount',
      desc: '',
      args: [],
    );
  }

  /// `Redeemed Points`
  String get redeem_points {
    return Intl.message(
      'Redeemed Points',
      name: 'redeem_points',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Rewarded Points`
  String get rewarded_points {
    return Intl.message(
      'Rewarded Points',
      name: 'rewarded_points',
      desc: '',
      args: [],
    );
  }

  /// `Used coupons`
  String get used_coupons {
    return Intl.message(
      'Used coupons',
      name: 'used_coupons',
      desc: '',
      args: [],
    );
  }

  /// `City is changed successfully`
  String get city_is_changed {
    return Intl.message(
      'City is changed successfully',
      name: 'city_is_changed',
      desc: '',
      args: [],
    );
  }

  /// ` Delete Account`
  String get delete_account {
    return Intl.message(
      ' Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Searching`
  String get searching {
    return Intl.message(
      'Searching',
      name: 'searching',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get no_data {
    return Intl.message(
      'No Data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Yes Delete`
  String get yes_delete {
    return Intl.message(
      'Yes Delete',
      name: 'yes_delete',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get Reviews {
    return Intl.message(
      'Reviews',
      name: 'Reviews',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get Review {
    return Intl.message(
      'Review',
      name: 'Review',
      desc: '',
      args: [],
    );
  }

  /// ` Pay Using Wallet`
  String get Pay_Using_Wallet {
    return Intl.message(
      ' Pay Using Wallet',
      name: 'Pay_Using_Wallet',
      desc: '',
      args: [],
    );
  }

  /// `You Will earned +`
  String get You_Will_earned {
    return Intl.message(
      'You Will earned +',
      name: 'You_Will_earned',
      desc: '',
      args: [],
    );
  }

  /// `Add Your Review`
  String get Add_Your_Review {
    return Intl.message(
      'Add Your Review',
      name: 'Add_Your_Review',
      desc: '',
      args: [],
    );
  }

  /// `Your balance is :`
  String get your_balance_is {
    return Intl.message(
      'Your balance is :',
      name: 'your_balance_is',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// ` The Cart is Empty`
  String get The_Cart_is_Empty {
    return Intl.message(
      ' The Cart is Empty',
      name: 'The_Cart_is_Empty',
      desc: '',
      args: [],
    );
  }

  /// `Subscription end in :`
  String get Subscription_end_in {
    return Intl.message(
      'Subscription end in :',
      name: 'Subscription_end_in',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get More {
    return Intl.message(
      'More',
      name: 'More',
      desc: '',
      args: [],
    );
  }

  /// `and you cannot purchase via points`
  String get and_you_cannot_purchase_via_points {
    return Intl.message(
      'and you cannot purchase via points',
      name: 'and_you_cannot_purchase_via_points',
      desc: '',
      args: [],
    );
  }

  /// `Go Shopping`
  String get Go_Shopping {
    return Intl.message(
      'Go Shopping',
      name: 'Go_Shopping',
      desc: '',
      args: [],
    );
  }

  /// `Redeem`
  String get Redeem {
    return Intl.message(
      'Redeem',
      name: 'Redeem',
      desc: '',
      args: [],
    );
  }

  /// `Oops...`
  String get Oops {
    return Intl.message(
      'Oops...',
      name: 'Oops',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get Confirmation {
    return Intl.message(
      'Confirmation',
      name: 'Confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to Delete Account ?`
  String get do_you_want {
    return Intl.message(
      'Do you want to Delete Account ?',
      name: 'do_you_want',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete your account?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure to delete your account?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `If you delete your account, you will lost all your data in the application, and you cannot retrieve your account!`
  String get if_you_delete {
    return Intl.message(
      'If you delete your account, you will lost all your data in the application, and you cannot retrieve your account!',
      name: 'if_you_delete',
      desc: '',
      args: [],
    );
  }

  /// `Buy Points and Redeemed it via buy Coupons or subscription packages`
  String
      get Buy_Points_and_Redeemed_it_via_buy_Coupons_or_subscription_packages {
    return Intl.message(
      'Buy Points and Redeemed it via buy Coupons or subscription packages',
      name:
          'Buy_Points_and_Redeemed_it_via_buy_Coupons_or_subscription_packages',
      desc: '',
      args: [],
    );
  }

  /// `All prices shown are inclusive of VAT where applicable`
  String get all_prices_shown_are_inclusive_of_VAT_where_applicable {
    return Intl.message(
      'All prices shown are inclusive of VAT where applicable',
      name: 'all_prices_shown_are_inclusive_of_VAT_where_applicable',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get send_otp {
    return Intl.message(
      'Send OTP',
      name: 'send_otp',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resend_otp {
    return Intl.message(
      'Resend OTP',
      name: 'resend_otp',
      desc: '',
      args: [],
    );
  }

  /// `Mobile already Exists`
  String get mobile_exists {
    return Intl.message(
      'Mobile already Exists',
      name: 'mobile_exists',
      desc: '',
      args: [],
    );
  }

  /// `Email already Exists`
  String get email_exists {
    return Intl.message(
      'Email already Exists',
      name: 'email_exists',
      desc: '',
      args: [],
    );
  }

  /// `Payment has been canceled`
  String get payment_canceled {
    return Intl.message(
      'Payment has been canceled',
      name: 'payment_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to repayment?`
  String get do_you_want_to_repayment {
    return Intl.message(
      'Do you want to repayment?',
      name: 'do_you_want_to_repayment',
      desc: '',
      args: [],
    );
  }

  /// `Per Year`
  String get per_year {
    return Intl.message(
      'Per Year',
      name: 'per_year',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Select Package`
  String get Select_Package {
    return Intl.message(
      'Select Package',
      name: 'Select_Package',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Points`
  String get number_of_points {
    return Intl.message(
      'Number Of Points',
      name: 'number_of_points',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get expiration_date {
    return Intl.message(
      'Expiration date',
      name: 'expiration_date',
      desc: '',
      args: [],
    );
  }

  /// `Points Wallet`
  String get Points_Wallet {
    return Intl.message(
      'Points Wallet',
      name: 'Points_Wallet',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `AVG Saving`
  String get AVG_Saving {
    return Intl.message(
      'AVG Saving',
      name: 'AVG_Saving',
      desc: '',
      args: [],
    );
  }

  /// `Please Login First`
  String get please_login_first {
    return Intl.message(
      'Please Login First',
      name: 'please_login_first',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Point Range`
  String get point_range {
    return Intl.message(
      'Point Range',
      name: 'point_range',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications`
  String get no_notifications {
    return Intl.message(
      'No Notifications',
      name: 'no_notifications',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
