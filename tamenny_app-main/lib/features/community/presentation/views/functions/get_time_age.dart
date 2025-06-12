import 'package:cloud_firestore/cloud_firestore.dart';

String getTimeAgo(Timestamp timestamp) {
  final DateTime dateTime = timestamp.toDate();
  final Duration difference = DateTime.now().difference(dateTime);
  if (difference.inMinutes < 1) {
    return 'now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else {
    return '${(difference.inDays / 7).floor()} weeks ago';
  }
}
