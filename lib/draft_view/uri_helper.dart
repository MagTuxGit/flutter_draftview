import 'package:url_launcher/url_launcher.dart' as plugin;

class UriHelper {
  static Future<void> launchUrl(String url) async {
    if (!url.startsWith('http')) {
      url = 'https://$url';
    };

    final link = Uri.parse(url);
    if (await plugin.canLaunchUrl(link)) {
      await plugin.launchUrl(link);
    }
  }
}
