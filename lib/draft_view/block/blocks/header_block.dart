import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class HeaderBlock extends BaseBlock {
  /// Entity type
  final int level;

  HeaderBlock({
    required super.depth,
    required super.start,
    required super.end,
    required super.inlineStyles,
    required super.data,
    required super.text,
    required super.entityTypes,
    required super.blockType,
    required this.level,
    required List<BaseBlock> super.children,
  });

  @override
  HeaderBlock copyWith({BaseBlock? block}) => HeaderBlock(
        depth: block?.depth ?? depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        level: this.level,
        children: block?.children ?? children ?? [],
      );

  @override
  TextStyle renderStyle(BuildContext context, TextStyle? baseStyle,
      {Map<String, Color>? textColorMap,
      Map<String, Tuple2<Color, Color?>>? highlightColorMap}) {
    var prevStyle = super.renderStyle(context, baseStyle);

    switch (level) {
      case 1:
        var textStyle = Theme.of(context).textTheme.displayLarge!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context, baseStyle?.color),
            );
        return textStyle;

      case 2:
        var textStyle = Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context, baseStyle?.color),
            );

        return textStyle;

      case 3:
        var textStyle = Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context, baseStyle?.color),
            );
        return textStyle;
      case 4:
        var textStyle = Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context, baseStyle?.color),
            );
        return textStyle;
      case 5:
        var textStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context, baseStyle?.color),
            );
        return textStyle;
      default:
        var textStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: prevStyle.fontWeight,
              fontStyle: prevStyle.fontStyle,
              decoration: prevStyle.decoration,
              color: textColor(context, baseStyle?.color),
            );
        return textStyle;
    }
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
        text: textContent, style: renderStyle(context, baseStyle));
  }
}
