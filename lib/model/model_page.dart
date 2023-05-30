import 'package:cloud_firestore/cloud_firestore.dart';

class PageModel {
  late String id;
  late String title;
  late int price;


  PageModel({
    required this.id,
    required this.title,
    required this.price,
  });

  PageModel.fromSnapshot(DocumentSnapshot snapshot){
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;

    title = data['title'];
    price = data['price'];
  }
}