import 'package:url_launcher/url_launcher.dart';

abstract class CustomUrlHandler {
  Future<void> openUrl({required String url});
}

class CustomUrlLuncher extends CustomUrlHandler {
  @override
  Future<void> openUrl({required String url}) async {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}
