// @dart=2.9

// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:multiple_localization/multiple_localization.dart';

import 'messages_all.dart';

class S {
  static Map<String, Map<String, String>> translations = {};
  static Locale _locale;

  String overridenTranslation(
      String key, String languageCode, String countryCode) {
    var languageTag = getLanguageTag(languageCode, countryCode);
    var languageTranslations = translations[languageTag];
    if (languageTranslations != null &&
        languageTranslations.containsKey(key) &&
        languageTranslations[key].isNotEmpty) {
      return languageTranslations[key];
    }

    return null;
  }

  String getLanguageTag(String languageCode, String countryCode) {
    if (languageCode == null) {
      return null;
    }
    if (countryCode == null) {
      return languageCode;
    }
    return '$languageCode-$countryCode';
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
  
  static S load(Locale locale) {
    _locale = locale;
    return S();
  }
  
  String genderMessage(targetGender, name) {
    // TODO
    var ot = overridenTranslation(
        'genderMessage', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.gender(targetGender,
        male: "Hi ${name}, He is boy.",
        female: "Hi ${name}, She is girl.",
        other: "Hi ${name}, he/she is boy/girl.",
        name: 'genderMessage',
        args: [targetGender, name]);
  }

  String get locale {
    var ot = overridenTranslation(
        'locale', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.message("English", name: 'locale');
  }

  String messageWithParams(dynamic yourName) {
    var ot = overridenTranslation(
        'messageWithParams', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.message("Hi ${yourName}, Welcome you!", name: 'messageWithParams', args: [yourName]);
  }

  String pluralMessage(howMany, interviewerName) {
    // TODO
    var ot = overridenTranslation(
        'pluralMessage', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.plural(howMany,
        zero: null,
        one: "Hi ${interviewerName}, I have one year working experience.",
        two: null,
        few: null,
        many: null,
        other: "Hi ${interviewerName}, I have ${howMany} years of working experience.",
        name: 'pluralMessage',
        args: [howMany, interviewerName]);
  }

  String get simpleMessage {
    var ot = overridenTranslation(
        'simpleMessage', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.message("This is a simple Message", name: 'simpleMessage');
  }

  String get specialCharactersMessage {
    var ot = overridenTranslation(
        'specialCharactersMessage', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.message("Special Characters Nice Developer's \"Message\"\n Next Line", name: 'specialCharactersMessage');
  }



  Map<String, String> get _translate => <String, String>{
		'locale' : locale,
		'simpleMessage' : simpleMessage,
		'specialCharactersMessage' : specialCharactersMessage,

  };

  @deprecated
  String tr(String key) {
    return _translate[key] ?? key;
  }
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("en", ""),
			Locale("ja", ""),
			Locale("zh", "TW"),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return MultipleLocalizations.load(
        initializeMessages, locale, (l) => S.load(locale),
        setDefaultLocale: true);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps
