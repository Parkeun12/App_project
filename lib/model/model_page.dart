import 'package:cloud_firestore/cloud_firestore.dart';

class PageModel {
  late String id;
  late String title;
  late String imageUrl;
  late String website;

  PageModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.website,
  });

  PageModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic>? data = snapshot.data();
    id = snapshot.id;
    title = data?['title'] ?? '';
    imageUrl = data?['imageUrl'] ?? '';
    website = data?['website'] ?? '';
  }

}