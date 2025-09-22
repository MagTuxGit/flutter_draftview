import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart' as plugin;

class UriHelper {
  static Future<void> launchUrl(String url) async {
    if (!url.startsWith('http')) {
      url = 'https://$url';
    }

    final link = Uri.parse(url);
    if (await plugin.canLaunchUrl(link)) {
      await plugin.launchUrl(link, mode: plugin.LaunchMode.externalApplication);
    }
  }
}

class LinkHandler extends InheritedWidget {
  final void Function(String url) onLinkClicked;

  const LinkHandler({
    super.key,
    required this.onLinkClicked,
    required super.child,
  });

  static LinkHandler? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LinkHandler>();
  }

  @override
  bool updateShouldNotify(LinkHandler oldWidget) =>
      onLinkClicked != oldWidget.onLinkClicked;
}
