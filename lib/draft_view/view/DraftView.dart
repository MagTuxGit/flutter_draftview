import 'package:collection/collection.dart';
import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:draft_view/draft_view/converter/converter.dart';
import 'package:draft_view/draft_view/plugin/base_plugin.dart';
import 'package:flutter/material.dart';

class DraftView extends StatefulWidget {
  final Map<String, dynamic> rawDraftData;
  final List<BasePlugin> plugins;
  final TextStyle? baseStyle;
  final Map<String, Color>? textColorMap;
  final Map<String, Color>? highlightColorMap;

  const DraftView({
    Key? key,
    required this.rawDraftData,
    required this.plugins,
    this.baseStyle,
    this.textColorMap,
    this.highlightColorMap,
  }) : super(key: key);

  @override
  _DraftViewState createState() => _DraftViewState();
}

class _DraftViewState extends State<DraftView> {
  List<BaseBlock> blocks = [];

  @override
  void initState() {
    super.initState();
    blocks = _convertToBlocks();
  }

  @override
  void didUpdateWidget(DraftView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.plugins != widget.plugins ||
        oldWidget.rawDraftData != widget.rawDraftData ||
        oldWidget.baseStyle != widget.baseStyle) {
      setState(() {
        blocks = _convertToBlocks();
      });
    }
  }

  List<BaseBlock> _convertToBlocks() {
    final converter =
        Converter(plugins: widget.plugins, draftData: widget.rawDraftData);
    return converter.convert();
  }

  List<InlineSpan> _renderText() {
    List<InlineSpan> spans = [];
    int i = 0;

    while (i < blocks.length) {
      var curBlock = blocks[i];

      var span = curBlock.render(context,
          children: curBlock.children
              ?.map((e) => e.render(context,
                  baseStyle: widget.baseStyle,
                  textColorMap: widget.textColorMap,
                  highlightColorMap: widget.highlightColorMap))
              .toList(),
          baseStyle: widget.baseStyle,
          textColorMap: widget.textColorMap,
          highlightColorMap: widget.highlightColorMap);
      spans.add(span);

      i++;
    }
    return spans;
  }

  TextAlign _textAlign() {
    final alignment = blocks.firstOrNull?.data['textAlignment'];
    switch (alignment) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.end;
    }
    return TextAlign.start;
  }

  @override
  Widget build(BuildContext context) {
    final textAlign = _textAlign();
    Alignment widgetAlignment;
    switch (textAlign) {
      case TextAlign.left:
      case TextAlign.justify:
      case TextAlign.start:
        widgetAlignment = Alignment.centerLeft;
        break;
      case TextAlign.right:
      case TextAlign.end:
        widgetAlignment = Alignment.centerRight;
        break;
      case TextAlign.center:
        widgetAlignment = Alignment.center;
        break;
    }

    /// Align to prevent spans stretch
    /// If there is a single link span, then it will be clickable along the whole DraftView
    return Align(
      alignment: widgetAlignment,
      child: RichText(
        text: TextSpan(
          children: _renderText(),
        ),
        textAlign: textAlign,
      ),
    );
  }
}
