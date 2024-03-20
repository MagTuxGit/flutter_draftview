import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class ImageBlock extends BaseBlock {
  ImageBlock({
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
  ImageBlock copyWith({BaseBlock? block}) => ImageBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
      );

  @override
  InlineSpan render(
    BuildContext context, {
    List<InlineSpan>? children,
    TextStyle? baseStyle,
    Map<String, Color>? textColorMap,
    Map<String, Tuple2<Color, Color?>>? highlightColorMap,
  }) {
    return WidgetSpan(
      child: ImageComponent(
        url: data['src'],
        caption: data['description'],
      ),
    );
  }
}

class ImageComponent extends StatefulWidget {
  final String? url;
  final String? caption;

  const ImageComponent({super.key, this.url, this.caption});

  @override
  State<ImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (c) => ImageDetailView(
                url: widget.url,
                caption: widget.caption,
              ),
            );
          },
          child: widget.url != null
              ? Center(
                  child: Image.network(
                    widget.url!,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: Colors.grey.withOpacity(0.4),
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  height: 200,
                  color: Colors.grey.withOpacity(0.4),
                ),
        ),
        Hero(
          tag: Key("${widget.caption}"),
          child: Text("${widget.caption}"),
        ),
      ],
    );
  }
}

class ImageDetailView extends StatefulWidget {
  final String? url;
  final String? caption;

  const ImageDetailView({super.key, this.url, this.caption});

  @override
  State<ImageDetailView> createState() => _ImageDetailViewState();
}

class _ImageDetailViewState extends State<ImageDetailView> {
  final TransformationController _transformationController =
      TransformationController();

  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      if (_doubleTapDetails != null) {
        final position = _doubleTapDetails!.localPosition;
        // For a 3x zoom
        _transformationController.value = Matrix4.identity()
          ..translate(-position.dx, -position.dy)
          ..scale(2.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          if (widget.url != null)
            Center(
              child: GestureDetector(
                onDoubleTapDown: _handleDoubleTapDown,
                onDoubleTap: _handleDoubleTap,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  panEnabled: false,
                  boundaryMargin: const EdgeInsets.all(100),
                  minScale: 0.5,
                  maxScale: 3,
                  child: Image.network(
                    widget.url!,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: Key("${widget.caption}"),
                  child: Text(
                    widget.caption ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          )
        ],
      ),
    );
  }
}
