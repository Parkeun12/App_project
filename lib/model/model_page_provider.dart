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
      final String lowercaseQuery = query.toLowerCase();

      // Search by hashtags
      final QuerySnapshot<Map<String, dynamic>> hashtagsQuerySnapshot =
      await itemsQuery.where('hashtags', arrayContains: lowercaseQuery).get();

      // Search by title
      final QuerySnapshot<Map<String, dynamic>> titleQuerySnapshot =
      await itemsQuery.where('title', isEqualTo: lowercaseQuery).get();

      final List<PageModel> pages = [];

      // Add search results from hashtags query
      for (final DocumentSnapshot<Map<String, dynamic>> document in hashtagsQuerySnapshot.docs) {
        pages.add(PageModel.fromSnapshot(document));
      }

      // Add search results from title query
      for (final DocumentSnapshot<Map<String, dynamic>> document in titleQuerySnapshot.docs) {
        final PageModel page = PageModel.fromSnapshot(document);

        // Check if the page is already added from hashtags query to avoid duplicates
        if (!pages.contains(page)) {
          pages.add(page);
        }
      }

      searchItem = pages;
    } else {
      final QuerySnapshot<Map<String, dynamic>> results = await itemsQuery.orderBy('title').get();

      pages = results.docs.map((document) {
        return PageModel.fromSnapshot(document);
      }).toList();
    }

    notifyListeners();
  }

  Future<void> search(String query) async {
    fetchItems(query: query);
  }

  void clearSearch() {
    searchItem.clear();
    notifyListeners();
  }
}
