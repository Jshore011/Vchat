import 'dart:ui';

import 'package:flutter/painting.dart';

class ChatroomKeyword {
  const ChatroomKeyword(
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

const List<ChatroomKeyword> kChatroomKeywords = const <ChatroomKeyword>[
  ChatroomKeyword('#Chatroom', FlutterColors.yellow, 100, false),
  ChatroomKeyword('#Keyword', FlutterColors.gray600, 24, false),
  ChatroomKeyword('#Tag', FlutterColors.blue600, 12, true),
  ChatroomKeyword('#Cloud', FlutterColors.gray, 14, false),
  ChatroomKeyword('#Analytics', FlutterColors.blue400, 16, false),
  ChatroomKeyword('#Screen', FlutterColors.blue600, 12, true),
  ChatroomKeyword('#Showing', FlutterColors.gray600, 20, true),
  ChatroomKeyword('#ThatItIs', FlutterColors.blue, 36, false),
  ChatroomKeyword('#Working', FlutterColors.blue400, 40, false),
  ChatroomKeyword('#VChat', FlutterColors.gray, 32, true),
  ChatroomKeyword('#Team', FlutterColors.gray, 12, false),
  ChatroomKeyword('#Graduating', FlutterColors.gray600, 14, false),
  ChatroomKeyword('#Spring', FlutterColors.blue600, 16, false),
  ChatroomKeyword('#2022', FlutterColors.blue600, 20, true),
];