import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  ];

  /// No description provided for @welcome_to_servana.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Servana'**
  String get welcome_to_servana;

  /// No description provided for @experience_quick_seamless_service.
  ///
  /// In en, this message translates to:
  /// **'Experience quick and seamless service solutions delivered right to your doorstep'**
  String get experience_quick_seamless_service;

  /// No description provided for @receive_professional_help_on_time.
  ///
  /// In en, this message translates to:
  /// **'Receive professional help exactly when you need it'**
  String get receive_professional_help_on_time;

  /// No description provided for @request_services_from_comfort_of_home.
  ///
  /// In en, this message translates to:
  /// **'Request expert home services with just a tap — all from the comfort of your home'**
  String get request_services_from_comfort_of_home;

  /// No description provided for @btn_cont.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btn_cont;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account ?'**
  String get already_have_an_account;

  /// No description provided for @choose_your_food.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Food'**
  String get choose_your_food;

  /// No description provided for @turn_on_your_location.
  ///
  /// In en, this message translates to:
  /// **'Turn On Your Location'**
  String get turn_on_your_location;

  /// No description provided for @yes_turn_it_on.
  ///
  /// In en, this message translates to:
  /// **'Yes, Turn It On'**
  String get yes_turn_it_on;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dont_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_an_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get remember_me;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @added_to_cart_successfully.
  ///
  /// In en, this message translates to:
  /// **'Item added to cart successfully'**
  String get added_to_cart_successfully;

  /// No description provided for @failed_to_add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Failed to add item to cart'**
  String get failed_to_add_to_cart;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continue_with_google;

  /// No description provided for @continue_with_facebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continue_with_facebook;

  /// No description provided for @continue_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continue_with_apple;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name;

  /// No description provided for @invalid_first_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid first name (min 2 chars)'**
  String get invalid_first_name;

  /// No description provided for @invalid_last_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid last name (min 2 chars)'**
  String get invalid_last_name;

  /// No description provided for @invalid_phone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number format'**
  String get invalid_phone;

  /// No description provided for @weak_password.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get weak_password;

  /// No description provided for @fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get fill_all_fields;

  /// No description provided for @registration_success.
  ///
  /// In en, this message translates to:
  /// **'Registration completed successfully!'**
  String get registration_success;

  /// No description provided for @registration_failed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed, please try again'**
  String get registration_failed;

  /// No description provided for @birth_date.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birth_date;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @set_password.
  ///
  /// In en, this message translates to:
  /// **'Set Password'**
  String get set_password;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @enter_your_email_or_phone_and_we_will_send_you_a_link_to_get_back_into_your_account.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone and we\'ll send you a link to access your account'**
  String
  get enter_your_email_or_phone_and_we_will_send_you_a_link_to_get_back_into_your_account;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @reset_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset password. Please try again.'**
  String get reset_failed;

  /// No description provided for @back_to_login_page.
  ///
  /// In en, this message translates to:
  /// **'Back to login page'**
  String get back_to_login_page;

  /// No description provided for @password_reset_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully'**
  String get password_reset_successfully;

  /// No description provided for @update_password.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get update_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @current_location.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get current_location;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @top_rated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get top_rated;

  /// No description provided for @search_service_workers_or_etc.
  ///
  /// In en, this message translates to:
  /// **'Search workers, etc'**
  String get search_service_workers_or_etc;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @load_more.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get load_more;

  /// No description provided for @we_will_send_you_an_order_details_to_your_email_after_the_successfull_payment.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send order details to your email after successful payment'**
  String
  get we_will_send_you_an_order_details_to_your_email_after_the_successfull_payment;

  /// No description provided for @my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// No description provided for @personal_information.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personal_information;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// No description provided for @push_notifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get push_notifications;

  /// No description provided for @promotional_notifications.
  ///
  /// In en, this message translates to:
  /// **'Promotional Notifications'**
  String get promotional_notifications;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @help_center.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get user_name;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @to_continues_let_your_device_turn_on_location_which_uses_googles_location_service.
  ///
  /// In en, this message translates to:
  /// **'to continues, let your device turn on location, which uses google’s location service'**
  String
  get to_continues_let_your_device_turn_on_location_which_uses_googles_location_service;

  /// No description provided for @btn_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get btn_cancel;

  /// No description provided for @btn_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get btn_send;

  /// No description provided for @back_to.
  ///
  /// In en, this message translates to:
  /// **'Back To'**
  String get back_to;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @a_4_digit_code_has_been_sent_to_your_email_please_enter_it_to_verify.
  ///
  /// In en, this message translates to:
  /// **'A 4-digit code has been sent to your email. Please enter it to verify.'**
  String
  get a_4_digit_code_has_been_sent_to_your_email_please_enter_it_to_verify;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @want_to_try_with_my_current_password.
  ///
  /// In en, this message translates to:
  /// **'Want to try with my current password?'**
  String get want_to_try_with_my_current_password;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @pluming.
  ///
  /// In en, this message translates to:
  /// **'Pluming '**
  String get pluming;

  /// No description provided for @electrical.
  ///
  /// In en, this message translates to:
  /// **'Electrical'**
  String get electrical;

  /// No description provided for @gardner.
  ///
  /// In en, this message translates to:
  /// **'Gardner'**
  String get gardner;

  /// No description provided for @cleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get cleaning;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @paint.
  ///
  /// In en, this message translates to:
  /// **'Paint'**
  String get paint;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome! Are you a client or worker?'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please choose one of the options below.'**
  String get welcomeSubtitle;

  /// No description provided for @loginAsClient.
  ///
  /// In en, this message translates to:
  /// **'Login as Client'**
  String get loginAsClient;

  /// No description provided for @loginAsWorker.
  ///
  /// In en, this message translates to:
  /// **'Login as Worker'**
  String get loginAsWorker;

  /// No description provided for @jobDetails.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get jobDetails;

  /// No description provided for @clientName.
  ///
  /// In en, this message translates to:
  /// **'Client Name'**
  String get clientName;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @issueDescription.
  ///
  /// In en, this message translates to:
  /// **'Issue Description'**
  String get issueDescription;

  /// No description provided for @issueText.
  ///
  /// In en, this message translates to:
  /// **'Kitchen sink is leaking under the cabinet.\nWater is pooling inside the cabinet whenever the faucet is turned on.'**
  String get issueText;

  /// No description provided for @hourlyRate.
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate'**
  String get hourlyRate;

  /// No description provided for @startWork.
  ///
  /// In en, this message translates to:
  /// **'Start Work'**
  String get startWork;

  /// No description provided for @bottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomNavHome;

  /// No description provided for @bottomNavWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get bottomNavWallet;

  /// No description provided for @bottomNavHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get bottomNavHistory;

  /// No description provided for @bottomNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavProfile;

  /// No description provided for @profession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get profession;

  /// No description provided for @select_profession.
  ///
  /// In en, this message translates to:
  /// **'Select your profession'**
  String get select_profession;

  /// No description provided for @plumber.
  ///
  /// In en, this message translates to:
  /// **'Plumber'**
  String get plumber;

  /// No description provided for @electrician.
  ///
  /// In en, this message translates to:
  /// **'Electrician'**
  String get electrician;

  /// No description provided for @painter.
  ///
  /// In en, this message translates to:
  /// **'Painter'**
  String get painter;

  /// No description provided for @error_fill_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields and select gender and profession'**
  String get error_fill_fields;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @personal_info.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personal_info;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @rate_worker.
  ///
  /// In en, this message translates to:
  /// **'Rate Worker'**
  String get rate_worker;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @search_workers.
  ///
  /// In en, this message translates to:
  /// **'Search workers, etc'**
  String get search_workers;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @top_rated_workers.
  ///
  /// In en, this message translates to:
  /// **'Top Rated Workers'**
  String get top_rated_workers;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobs;

  /// No description provided for @plumbing.
  ///
  /// In en, this message translates to:
  /// **'Plumbing'**
  String get plumbing;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @your_balance.
  ///
  /// In en, this message translates to:
  /// **'Your Balance'**
  String get your_balance;

  /// No description provided for @add_money.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get add_money;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @transaction_history.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get transaction_history;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @job_completed_title.
  ///
  /// In en, this message translates to:
  /// **'Your job has been completed'**
  String get job_completed_title;

  /// No description provided for @job_completed_body.
  ///
  /// In en, this message translates to:
  /// **'The worker marked your job as completed'**
  String get job_completed_body;

  /// No description provided for @payment_received_title.
  ///
  /// In en, this message translates to:
  /// **'Payment received'**
  String get payment_received_title;

  /// No description provided for @payment_received_body.
  ///
  /// In en, this message translates to:
  /// **'Your payment has been processed'**
  String get payment_received_body;

  /// No description provided for @new_message_title.
  ///
  /// In en, this message translates to:
  /// **'You have a new message'**
  String get new_message_title;

  /// No description provided for @new_message_body_1.
  ///
  /// In en, this message translates to:
  /// **'The worker: Hello, I\'m on my way'**
  String get new_message_body_1;

  /// No description provided for @new_message_body_2.
  ///
  /// In en, this message translates to:
  /// **'The worker: I will arrive shortly'**
  String get new_message_body_2;

  /// No description provided for @job_started_title.
  ///
  /// In en, this message translates to:
  /// **'Job started'**
  String get job_started_title;

  /// No description provided for @job_started_body.
  ///
  /// In en, this message translates to:
  /// **'The worker started the job'**
  String get job_started_body;

  /// No description provided for @job_request_accepted_title.
  ///
  /// In en, this message translates to:
  /// **'Job request accepted'**
  String get job_request_accepted_title;

  /// No description provided for @job_request_accepted_body.
  ///
  /// In en, this message translates to:
  /// **'The worker accepted your request'**
  String get job_request_accepted_body;

  /// No description provided for @plumbers.
  ///
  /// In en, this message translates to:
  /// **'Plumbers'**
  String get plumbers;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request?'**
  String get request;

  /// No description provided for @jd_per_hour.
  ///
  /// In en, this message translates to:
  /// **'JD {price}/hr'**
  String jd_per_hour(Object price);

  /// No description provided for @request_question.
  ///
  /// In en, this message translates to:
  /// **'Request?'**
  String get request_question;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @request_service_title.
  ///
  /// In en, this message translates to:
  /// **'Request a Service'**
  String get request_service_title;

  /// No description provided for @describe_issue_hint.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue you need help with'**
  String get describe_issue_hint;

  /// No description provided for @submit_request_button.
  ///
  /// In en, this message translates to:
  /// **'Request Service'**
  String get submit_request_button;

  /// No description provided for @request_success_message.
  ///
  /// In en, this message translates to:
  /// **'Request A Service Submitted Successfully!'**
  String get request_success_message;

  /// No description provided for @servana.
  ///
  /// In en, this message translates to:
  /// **'Servana'**
  String get servana;

  /// No description provided for @rate_experience.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Experience'**
  String get rate_experience;

  /// No description provided for @leave_review.
  ///
  /// In en, this message translates to:
  /// **'Leave A Review (Optional)'**
  String get leave_review;

  /// No description provided for @rating_submitted.
  ///
  /// In en, this message translates to:
  /// **'Rating Submitted Successfully!'**
  String get rating_submitted;

  /// No description provided for @submit_rating.
  ///
  /// In en, this message translates to:
  /// **'Submit Rating'**
  String get submit_rating;

  /// No description provided for @rating_submitted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Rating Submitted Successfully!'**
  String get rating_submitted_successfully;

  /// No description provided for @new_job_assigned.
  ///
  /// In en, this message translates to:
  /// **'New job assigned'**
  String get new_job_assigned;

  /// No description provided for @you_accepted_job.
  ///
  /// In en, this message translates to:
  /// **'You have accepted a new job'**
  String get you_accepted_job;

  /// No description provided for @job_started.
  ///
  /// In en, this message translates to:
  /// **'Job started'**
  String get job_started;

  /// No description provided for @you_started_job.
  ///
  /// In en, this message translates to:
  /// **'You marked the job as started'**
  String get you_started_job;

  /// No description provided for @payment_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Payment confirmed'**
  String get payment_confirmed;

  /// No description provided for @client_confirmed_payment.
  ///
  /// In en, this message translates to:
  /// **'The client confirmed payment'**
  String get client_confirmed_payment;

  /// No description provided for @new_message_from_client.
  ///
  /// In en, this message translates to:
  /// **'New message from client'**
  String get new_message_from_client;

  /// No description provided for @job_completed.
  ///
  /// In en, this message translates to:
  /// **'Job completed'**
  String get job_completed;

  /// No description provided for @you_completed_job.
  ///
  /// In en, this message translates to:
  /// **'You marked the job as done'**
  String get you_completed_job;

  /// No description provided for @job_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Job cancelled'**
  String get job_cancelled;

  /// No description provided for @client_cancelled_request.
  ///
  /// In en, this message translates to:
  /// **'The client cancelled the request'**
  String get client_cancelled_request;

  /// No description provided for @worker_title.
  ///
  /// In en, this message translates to:
  /// **'Worker'**
  String get worker_title;

  /// No description provided for @welcome_text.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome_text;

  /// No description provided for @search_for_tasks.
  ///
  /// In en, this message translates to:
  /// **'Search for tasks and jobs'**
  String get search_for_tasks;

  /// No description provided for @notification_card_title.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification_card_title;

  /// No description provided for @notification_card_sub.
  ///
  /// In en, this message translates to:
  /// **'You Have A New Notification'**
  String get notification_card_sub;

  /// No description provided for @job_request_title.
  ///
  /// In en, this message translates to:
  /// **'Job Request'**
  String get job_request_title;

  /// No description provided for @job_request_sub.
  ///
  /// In en, this message translates to:
  /// **'Click On It To See Requests'**
  String get job_request_sub;

  /// No description provided for @end_work_title.
  ///
  /// In en, this message translates to:
  /// **'End Work'**
  String get end_work_title;

  /// No description provided for @end_work_sub.
  ///
  /// In en, this message translates to:
  /// **'Click On It To End Work'**
  String get end_work_sub;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_title;

  /// No description provided for @profile_sub.
  ///
  /// In en, this message translates to:
  /// **'See Your Profile'**
  String get profile_sub;

  /// No description provided for @your_name.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get your_name;

  /// No description provided for @your_email.
  ///
  /// In en, this message translates to:
  /// **'your@email.com'**
  String get your_email;

  /// No description provided for @take_from_camera.
  ///
  /// In en, this message translates to:
  /// **'Take from Camera'**
  String get take_from_camera;

  /// No description provided for @price_per_hour.
  ///
  /// In en, this message translates to:
  /// **'Price Per Hour'**
  String get price_per_hour;

  /// No description provided for @profile_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profile_updated_successfully;

  /// No description provided for @pick_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Pick from Gallery'**
  String get pick_from_gallery;

  /// No description provided for @job_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Job In Progress'**
  String get job_in_progress;

  /// No description provided for @client_name.
  ///
  /// In en, this message translates to:
  /// **'Client Name'**
  String get client_name;

  /// No description provided for @issue.
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get issue;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @working_status.
  ///
  /// In en, this message translates to:
  /// **'Working'**
  String get working_status;

  /// No description provided for @end_work.
  ///
  /// In en, this message translates to:
  /// **'End Work'**
  String get end_work;

  /// No description provided for @end_work_success.
  ///
  /// In en, this message translates to:
  /// **'Ended Work Successfully'**
  String get end_work_success;

  /// No description provided for @incoming_requests.
  ///
  /// In en, this message translates to:
  /// **'Incoming Requests'**
  String get incoming_requests;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @request_accepted.
  ///
  /// In en, this message translates to:
  /// **'Request Accepted'**
  String get request_accepted;

  /// No description provided for @request_declined.
  ///
  /// In en, this message translates to:
  /// **'Request Declined'**
  String get request_declined;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @hvac.
  ///
  /// In en, this message translates to:
  /// **'HVAC'**
  String get hvac;

  /// No description provided for @filterBy.
  ///
  /// In en, this message translates to:
  /// **'Filter By'**
  String get filterBy;

  /// No description provided for @lowerPrice.
  ///
  /// In en, this message translates to:
  /// **'Lower Price'**
  String get lowerPrice;

  /// No description provided for @higherPrice.
  ///
  /// In en, this message translates to:
  /// **'Higher Price'**
  String get higherPrice;

  /// No description provided for @topRated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get topRated;

  /// No description provided for @rateWorker.
  ///
  /// In en, this message translates to:
  /// **'Rate Worker'**
  String get rateWorker;

  /// No description provided for @jd.
  ///
  /// In en, this message translates to:
  /// **'JD'**
  String get jd;

  /// No description provided for @hr.
  ///
  /// In en, this message translates to:
  /// **'hr'**
  String get hr;

  /// No description provided for @hourUnit.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hourUnit;

  /// No description provided for @incomingRequests.
  ///
  /// In en, this message translates to:
  /// **'Incoming Requests'**
  String get incomingRequests;

  /// No description provided for @incomingRequestsDesc.
  ///
  /// In en, this message translates to:
  /// **'View all new job requests from clients.'**
  String get incomingRequestsDesc;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSettings;

  /// No description provided for @profileSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage your personal and work details.'**
  String get profileSettingsDesc;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @no_notifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications available'**
  String get no_notifications;

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT'**
  String get paymentTitle;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @serviceFee.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get serviceFee;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @payForJob.
  ///
  /// In en, this message translates to:
  /// **'PAY FOR JOB'**
  String get payForJob;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @please_enter_email_and_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter both email and password'**
  String get please_enter_email_and_password;
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
      <String>['ar', 'en'].contains(locale.languageCode);

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
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
