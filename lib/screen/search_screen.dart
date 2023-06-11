import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_project/model/model_page_provider.dart';
import 'package:app_project/model/model_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  final int number;

  const SearchScreen({
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchPerformed = false;
  late final FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if (isSearchPerformed) {
          // Clear the search results and return to the initial search screen
          pageProvider.clearSearch();
          setState(() {
            isSearchPerformed = false;
          });
          return false; // prevent the default back navigation
        }
        return true; // allow the default back navigation
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Image.asset(
              'lib/asset/logo2.png',
              width: 100,
              height: 100,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (isSearchPerformed) {
                  // Clear the search results and return to the initial search screen
                  pageProvider.clearSearch();
                  setState(() {
                    isSearchPerformed = false;
                  });
                } else {
                  // Handle back button press
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  style: TextStyle(color: Colors.black),
                  onSubmitted: (_) {
                    // Perform the search
                    performSearch();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        // Perform the search
                        performSearch();
                      },
                      icon: Icon(Icons.search),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  void performSearch() {
    final pageProvider = Provider.of<PageProvider>(context, listen: false);
    final searchQuery = searchController.text.trim();

    pageProvider.search(searchQuery);
    setState(() {
      isSearchPerformed = true;
    });
    searchFocusNode.unfocus(); // unfocus the search field after performing the search
  }

  Widget buildSearchResults() {
    final pageProvider = Provider.of<PageProvider>(context);
    final searchResults = pageProvider.searchItem;
    final allPages = pageProvider.pages;

    if (searchResults.isEmpty) {
      if (allPages.isEmpty) {
        return Center(
          child: Text('No data available'),
        );
      }

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.1,
        ),
        itemCount: allPages.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: InkWell(
              onTap: () {
                _launchURL(allPages[index].website);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        allPages[index].imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      allPages[index].title,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.1,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: InkWell(
            onTap: () {
              _launchURL(searchResults[index].website);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      searchResults[index].imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    searchResults[index].title,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
