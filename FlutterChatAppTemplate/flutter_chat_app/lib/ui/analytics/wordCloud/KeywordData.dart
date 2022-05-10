import 'dart:ui';
import 'package:flutter/painting.dart';

class Keyword {
  const Keyword(
      this.hashtag,
      this.color,
      this.size,
      this.rotated,
      );
  final String hashtag;
  final Color color;
  final double size;
  final bool rotated;
}