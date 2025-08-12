import 'dart:ui';

import 'package:tuple/tuple.dart';

typedef TextColorResolver = Color? Function(String style);
typedef HighlightColorResolver = Tuple2<Color, Color?>? Function(String style);
