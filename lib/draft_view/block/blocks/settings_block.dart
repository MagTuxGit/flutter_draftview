import 'dart:io';

import 'package:draft_view/draft_view/block/base_block.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);
//     final postSettings = postSettingsFromJson(jsonString);
//     final detailSettings = detailSettingsFromJson(jsonString);

/// Post Settings object
class Settings {
  Settings({
    required this.settings,
  });

  List<PostSettings>? settings;

  Settings copyWith({
    List<PostSettings>? settings,
  }) =>
      Settings(
        settings: settings ?? this.settings,
      );

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        settings: json["settings"] == null
            ? []
            : List<PostSettings>.from(
                json["settings"].map(
                  (x) => PostSettings.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "settings": settings == null
            ? null
            : List<dynamic>.from(settings!.map((x) => x.toJson())),
      };
}

class PostSettings {
  PostSettings({
    required this.detailSettings,
    required this.id,
  });

  List<DetailSettings>? detailSettings;
  String? id;

  PostSettings copyWith({
    List<DetailSettings>? detailSettings,
    String? id,
  }) =>
      PostSettings(
        detailSettings: detailSettings ?? this.detailSettings,
        id: id ?? this.id,
      );

  factory PostSettings.fromJson(Map<String, dynamic> json) => PostSettings(
        detailSettings: json["detailSettings"] == null
            ? []
            : List<DetailSettings>.from(
                json["detailSettings"].map((x) => DetailSettings.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "detailSettings": detailSettings == null
            ? null
            : List<dynamic>.from(detailSettings!.map((x) => x.toJson())),
        "id": id,
      };
}

class DetailSettings {
  DetailSettings({
    required this.description,
    required this.name,
    required this.id,
  });

  String? description;
  String? name;
  String? id;

  DetailSettings copyWith({
    String? description,
    String? name,
    String? id,
  }) =>
      DetailSettings(
        description: description ?? this.description,
        name: name ?? this.name,
        id: id ?? this.id,
      );

  factory DetailSettings.fromJson(Map<String, dynamic> json) =>
      DetailSettings(
          description: json["description"],
          name: json["name"],
          id: json['id']);

  Map<String, dynamic> toJson() => {
        "description": description,
        "name": name,
        "id": id,
      };
}

/// Post setting's block. This block will be used to render the keyword (like a hashtag ) in blog.
/// For example [iPhone] is a post setting's block
class PostSettingsBlock extends BaseBlock {
  final Settings settings;

  PostSettingsBlock({
    required super.depth,
    required super.start,
    required super.end,
    required super.inlineStyles,
    required super.data,
    required super.text,
    required super.entityTypes,
    required super.blockType,
    required this.settings,
  });

  @override
  PostSettingsBlock copyWith({BaseBlock? block}) => PostSettingsBlock(
        depth: block?.depth ?? this.depth,
        start: block?.start ?? this.start,
        end: block?.end ?? this.end,
        inlineStyles: block?.inlineStyles ?? this.inlineStyles,
        entityTypes: block?.entityTypes ?? this.entityTypes,
        data: block?.data ?? this.data,
        text: block?.text ?? this.text,
        blockType: block?.blockType ?? this.blockType,
        settings: this.settings,
      );

  @override
  InlineSpan render(
    BuildContext context, {
    List<InlineSpan>? children,
    TextStyle? baseStyle,
    Map<String, Color>? textColorMap,
    Map<String, Tuple2<Color, Color?>>? highlightColorMap,
  }) {
    late DetailSettings detailSettings;
    var textStyle = renderStyle(context, baseStyle).copyWith(
      color: Colors.orange,
    );

    for (var setting in settings.settings ?? []) {
      for (var ds in setting?.detailSettings ?? []) {
        if (ds.id == data['id']) {
          detailSettings = ds;
        }
      }
    }

    var recognizer = TapGestureRecognizer()
      ..onTap = () {
        showBottomSheet(
          context: context,
          builder: (c) => PostSettingsCard(
            settings: detailSettings,
          ),
        );
      };
    bool useTooltip = false;

    if (kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      useTooltip = true;
    }

    return TextSpan(
      text: detailSettings.name,
      recognizer: recognizer,
      style: textStyle,
      children: useTooltip
          ? [
              WidgetSpan(
                style: textStyle,
                alignment: PlaceholderAlignment.middle,
                child: Tooltip(
                  message: detailSettings.description,
                  child: InkWell(
                    onHover: (_) {},
                    onTap: () {},
                    child: Icon(
                      Icons.link,
                      color: textStyle.color,
                      size: 20,
                    ),
                  ),
                ),
              )
            ]
          : null,
    );
  }
}

class PostSettingsCard extends StatelessWidget {
  final DetailSettings settings;

  const PostSettingsCard({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                title: Text(
                  "${settings.name}",
                ),
                subtitle: Text(
                  "${settings.description}",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 5,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }
}
