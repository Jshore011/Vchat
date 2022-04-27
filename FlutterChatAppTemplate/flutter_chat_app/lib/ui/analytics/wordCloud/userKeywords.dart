import 'dart:ui';

import 'package:flutter/painting.dart';

class UserKeyword {
  const UserKeyword(
      this.hashtag,
      this.color,
      this.size,
      this.rotated,
      );
  final String hashtag;
  final Color color;
  final int size;
  final bool rotated;
}

class FlutterColors {
  const FlutterColors._();

  static const Color yellow = Color(0xFFFFC108);

  static const Color white = Color(0xFFFFFFFF);

  static const Color blue400 = Color(0xFF13B9FD);
  static const Color blue600 = Color(0xFF0175C2);
  static const Color blue = Color(0xFF02569B);

  static const Color gray100 = Color(0xFFD5D7DA);
  static const Color gray600 = Color(0xFF60646B);
  static const Color gray = Color(0xFF202124);
}

const List<UserKeyword> kChatroomKeywords = const <UserKeyword>[
  UserKeyword('#User', FlutterColors.yellow, 100, false),
  UserKeyword('#Keyword', FlutterColors.gray600, 24, false),
  UserKeyword('#Tag', FlutterColors.blue600, 12, true),
  UserKeyword('#Cloud', FlutterColors.gray, 14, false),
  UserKeyword('#Analytics', FlutterColors.blue400, 16, false),
  UserKeyword('#Screen', FlutterColors.blue600, 12, true),
  UserKeyword('#Showing', FlutterColors.gray600, 20, true),
  UserKeyword('#ThatItIs', FlutterColors.blue, 36, false),
  UserKeyword('#Working', FlutterColors.blue400, 40, false),
  UserKeyword('#VChat', FlutterColors.gray, 32, true),
  UserKeyword('#Team', FlutterColors.gray, 12, false),
  UserKeyword('#Graduating', FlutterColors.gray600, 14, false),
  UserKeyword('#Spring', FlutterColors.blue600, 16, false),
  UserKeyword('#2022', FlutterColors.blue600, 20, true),
];