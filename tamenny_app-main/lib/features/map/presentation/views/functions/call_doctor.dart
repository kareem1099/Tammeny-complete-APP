import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void callDoctor(String phone) async {
  final Uri url = Uri.parse('tel:$phone');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    debugPrint('Could not launch $phone');
  }
}
