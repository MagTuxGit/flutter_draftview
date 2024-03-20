import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class BlockQuoteBlock extends BaseBlock {
  BlockQuoteBlock({
    required super.depth,
    required super.start,
    required super.end,
    required super.inlineStyles,
    required super.data,
    required super.text,
    required super.entityTypes,
    required super.blockType,
    required List<BaseBlock> super.children,
  });

  @override
  BlockQuoteBlock copyWith({BaseBlock? block}) => BlockQuoteBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        children: block?.children ?? this.children ?? [],
      );

  @override
  InlineSpan render(
    BuildContext context, {
    List<InlineSpan>? children,
    TextStyle? baseStyle,
    Map<String, Color>? textColorMap,
    Map<String, Tuple2<Color, Color?>>? highlightColorMap,
  }) {
    var style = renderStyle(context, baseStyle);
    var text = children?.isEmpty == true ? textContent : null;

    return WidgetSpan(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 10, color: Theme.of(context).primaryColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            key: Key("block-quote-content-$textContent"),
            text: TextSpan(
              text: text,
              children: children,
              style: style,
            ),
            textScaler: MediaQuery.textScalerOf(context),
          ),
        ),
      ),
    );
  }
}
