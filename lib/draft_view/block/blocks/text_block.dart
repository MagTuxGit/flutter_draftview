import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class TextBlock extends BaseBlock {
  TextBlock({
    required super.depth,
    required super.start,
    required super.end,
    required super.inlineStyles,
    required super.data,
    required super.text,
    required super.entityTypes,
    required super.blockType,
  });

  @override
  TextBlock copyWith({BaseBlock? block}) => TextBlock(
        depth: block?.depth ?? depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
      );
}

class NewlineBlock extends BaseBlock {
  NewlineBlock()
      : super(
          depth: 0,
          start: 0,
          end: 0,
          inlineStyles: [],
          data: {},
          text: "",
          entityTypes: [],
          blockType: "newline",
        );

  @override
  InlineSpan render(
    BuildContext context, {
    List<InlineSpan>? children,
    TextStyle? baseStyle,
    Map<String, Color>? textColorMap,
    Map<String, Tuple2<Color, Color?>>? highlightColorMap,
  }) {
    return TextSpan(text: "\n", style: renderStyle(context, baseStyle));
  }
}
