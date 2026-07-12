import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static Future<void> launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $urlString';
      }
    } catch (e) {
      // Quietly handle or log
      // ignore: avoid_print
      print(e.toString());
    }
  }

  static Future<void> launchEmail({
    required String email,
    String subject = '',
    String body = '',
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  static Future<void> launchWhatsApp({
    required String phone,
    required String text,
  }) async {
    final String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
    final String encodedText = Uri.encodeComponent(text);
    final String urlString = "https://wa.me/$cleanPhone?text=$encodedText";
    await launchURL(urlString);
  }
}
