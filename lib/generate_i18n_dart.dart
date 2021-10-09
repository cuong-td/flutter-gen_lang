import 'package:gen_lang/extra_json_file_tool.dart';
import 'package:gen_lang/extra_json_message_tool.dart';

String generateI18nDart(String getters, String supportedLocale,
    String gettersMap, String className) {
  return '''
// @dart=2.9

// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:multiple_localization/multiple_localization.dart';

import 'messages_all.dart';

class $className {
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
    return '\$languageCode-\$countryCode';
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static $className of(BuildContext context) {
    return Localizations.of<$className>(context, $className);
  }
  
  static $className load(Locale locale) {
    _locale = locale;
    return $className();
  }
  
$getters

  Map<String, String> get _translate => <String, String>{
$gettersMap
  };

  @deprecated
  String tr(String key) {
    return _translate[key] ?? key;
  }
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<$className> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
$supportedLocale
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
  Future<$className> load(Locale locale) {
    return MultipleLocalizations.load(
        initializeMessages, locale, (l) => $className.load(locale),
        setDefaultLocale: true);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps
''';
}

String generateGetterSimpleMessageFunction(String jsonKey, String message) {
  return '''
  String get ${toCamelCase(jsonKey)} {
    var ot = overridenTranslation(
        '$jsonKey', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.message("${normalizedJsonMessage(message)}", name: '$jsonKey');
  }
''';
}

String generateGetterMessageWithArgsFunction(
    String jsonKey, String message, Arguments args) {
  return '''
  String ${toCamelCase(jsonKey)}(${args.toTypedList()}) {
    var ot = overridenTranslation(
        '$jsonKey', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.message("${normalizedJsonMessage(message)}", name: '$jsonKey', args: [${args.toSimpleList()}]);
  }
''';
}

String generateGetterPluralFunction(String jsonKey, String args, String zero,
    String one, String two, String few, String many, String other) {
  var zeroArg = generateArg(normalizedJsonMessage(zero));
  var oneArg = generateArg(normalizedJsonMessage(one));
  var twoArg = generateArg(normalizedJsonMessage(two));
  var fewArg = generateArg(normalizedJsonMessage(few));
  var manyArg = generateArg(normalizedJsonMessage(many));
  var otherArg = generateArg(normalizedJsonMessage(other));

  return '''
  String ${toCamelCase(jsonKey)}($args) {
    // TODO
    var ot = overridenTranslation(
        '$jsonKey', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.plural(howMany,
        zero: $zeroArg,
        one: $oneArg,
        two: $twoArg,
        few: $fewArg,
        many: $manyArg,
        other: $otherArg,
        name: '$jsonKey',
        args: [$args]);
  }
''';
}

String generateGetterGenderFunction(
    String jsonKey, String args, String male, String female, String other) {
  var maleArg = generateArg(normalizedJsonMessage(male));
  var femaleArg = generateArg(normalizedJsonMessage(female));
  var otherArg = generateArg(normalizedJsonMessage(other));

  return '''
  String ${toCamelCase(jsonKey)}($args) {
    // TODO
    var ot = overridenTranslation(
        '$jsonKey', _locale?.languageCode, _locale?.countryCode);

    return ot ?? Intl.gender(targetGender,
        male: $maleArg,
        female: $femaleArg,
        other: $otherArg,
        name: '$jsonKey',
        args: [$args]);
  }
''';
}

String generateSupportedLocale(String locale) {
  String langCode = '';
  String countryCode = '';

  if (locale.contains('_')) {
    List<String> splits = locale.split('_');
    langCode = splits[0];
    countryCode = splits[1];
  } else {
    langCode = locale;
  }

  return '''\t\t\tLocale("$langCode", "$countryCode"),''';
}
