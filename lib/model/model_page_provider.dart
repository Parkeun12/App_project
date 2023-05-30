import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model_page.dart';

class PageProvider with ChangeNotifier {
  late CollectionReference pagesReference;
  List<PageModel> pages = [];

  PageProvider({reference}) {
    pagesReference =
        reference ?? FirebaseFirestore.instance.collection('Pages');
  }

  Future<void> fetchItems() async {
    pages = await pagesReference.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        return PageModel.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }
}
