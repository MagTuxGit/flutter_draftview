import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class ListBlock extends BaseBlock {
  /// List block's style
  final bool isOrderedList;

  /// Current order of the list. Ex: 1.; 2.; 3.;
  final int order;

  ListBlock({
    required this.order,
    required super.depth,
    required super.start,
    required super.end,
    required super.inlineStyles,
    required super.data,
    required super.text,
    required super.entityTypes,
    required super.blockType,
    required this.isOrderedList,
  });

  @override
  ListBlock copyWith({BaseBlock? block}) => ListBlock(
        depth: this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        isOrderedList: isOrderedList,
        order: this.order,
      );

  String getDepthSpacing() {
    String spacing = "";
    int i = 1;
    while (i < depth) {
      spacing += '      ';
      i += 1;
    }
    return spacing;
  }

  @override
  InlineSpan render(
    BuildContext context, {
    List<InlineSpan>? children,
    TextStyle? baseStyle,
    Map<String, Color>? textColorMap,
    Map<String, Tuple2<Color, Color?>>? highlightColorMap,
  }) {
    return TextSpan(
      text:
          "${getDepthSpacing()}${isOrderedList ? "$order." : "-"} $textContent\n",
      style: renderStyle(context, baseStyle),
    );
  }
}
