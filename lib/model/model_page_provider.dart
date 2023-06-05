import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model_page.dart';

class PageProvider with ChangeNotifier {
  late CollectionReference<Map<String, dynamic>> pagesReference;
  List<PageModel> pages = [];
  List<PageModel> searchItem = [];

  PageProvider({reference}) {
    pagesReference =
        reference ?? FirebaseFirestore.instance.collection('Pages');
    fetchItems();
  }

  Future<void> fetchItems({String? query}) async {
    Query<Map<String, dynamic>> itemsQuery = pagesReference;

    if (query != null && query.isNotEmpty) {
      itemsQuery = itemsQuery
          .where('hashtags', arrayContains: query)
          .orderBy('title')
          .startAt([query]).endAt([query + '\uf8ff']);
    }

    final results = await itemsQuery.get();

    List<PageModel> pages = results.docs.map((document) {
      return PageModel.fromSnapshot(document);
    }).toList();

    if (query != null && query.isNotEmpty) {
      searchItem = pages;
    } else {
      this.pages = pages;
    }

    notifyListeners();
  }

  Future<void> search(String query) async {
    fetchItems(query: query);
  }
}
