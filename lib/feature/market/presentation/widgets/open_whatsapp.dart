import 'package:url_launcher/url_launcher.dart';

Future<void>openWhatsApp()async{
  final phone = "201029232756";
  final message = "I want to order this product";

  final whatsappUrl = Uri.parse(
    "whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}"
  );

  final webUrl = Uri.parse(
    "https://wa.me/$phone?text=${Uri.encodeComponent(message)}"
  );

  
  if (await canLaunchUrl(whatsappUrl)) {
    await launchUrl(
      whatsappUrl,
      mode: LaunchMode.externalApplication,
    );
  } else {
    
    await launchUrl(
      webUrl,
      mode: LaunchMode.externalApplication,
    );
  }
}