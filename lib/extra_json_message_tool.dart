import 'package:gen_lang/extra_json_file_tool.dart';

RegExp ARG_REG_EXP = RegExp(r'\${\w+}');
const String DEFAULT_PLURAL_ARGS = 'howMany';
const String DEFAULT_GENDER_ARG = 'targetGender';

List<String> getArgs(Iterable<Match> allMatch, String defaultArg) {
  List<String> args = [];
  if (null != defaultArg) {
    args.add(defaultArg);
  }

  for (Match match in allMatch) {
    String arg = match.input.substring(match.start + 2, match.end - 1);
    if (!args.contains(arg)) {
      args.add(arg);
    }
  }

  return args;
}

String normalizedSpecialCharacters(String message) {
  if (null != message) {
    String normalizedJson = message.replaceAll(r"\", r"\\");
    return normalizedJson.replaceAll(r'\\"', r'\\\"');
  }
  return null;
}

String normalizedJsonMessage(String message) {
  if (null != message) {
    return message;
  }
  return null;
}

String generateArg(arg) {
  return null != arg ? '"$arg"' : 'null';
}

String extraArgsFromGender(String male, String female, String other) {
  List<String> plurals = [male, female, other];
  Iterable<Match> theMostMatch = [];

  for (String plural in plurals) {
    if (null != plural) {
      Iterable<Match> allMatch = ARG_REG_EXP.allMatches(plural);
      if (null == theMostMatch ||
          (null != theMostMatch && allMatch.length > theMostMatch.length)) {
        theMostMatch = allMatch;
      }
    }
  }

  StringBuffer builder = StringBuffer();
  List<String> args = getArgs(theMostMatch, DEFAULT_GENDER_ARG);
  for (int i = 0; i < args.length; i++) {
    if (i != 0) {
      builder.write(', ');
    }
    builder.write(args[i]);
  }

  return builder.toString();
}

String extraArgsFromPlural(String zero, String one, String two, String few,
    String many, String other) {
  List<String> plurals = [zero, one, two, few, many, other];
  Iterable<Match> theMostMatch = [];

  for (String plural in plurals) {
    if (null != plural) {
      Iterable<Match> allMatch = ARG_REG_EXP.allMatches(plural);
      if (null == theMostMatch ||
          (null != theMostMatch && allMatch.length > theMostMatch.length)) {
        theMostMatch = allMatch;
      }
    }
  }

  StringBuffer builder = StringBuffer();
  List<String> args = getArgs(theMostMatch, DEFAULT_PLURAL_ARGS);
  for (int i = 0; i < args.length; i++) {
    if (i != 0) {
      builder.write(', ');
    }
    builder.write(args[i]);
  }

  return builder.toString();
}

Arguments extraArgsFromMessage(String message) {
  List<String> args = getArgs(ARG_REG_EXP.allMatches(message), null);
  return Arguments(args);
}

String toCamelCase(String str) {
  String s = str
      .replaceAllMapped(
          RegExp(
              r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
          (Match m) =>
              "${m[0][0].toUpperCase()}${m[0].substring(1).toLowerCase()}")
      .replaceAll(RegExp(r'(_|-|\s)+'), '');
  return s[0].toLowerCase() + s.substring(1);
}
