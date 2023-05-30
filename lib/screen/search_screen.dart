import 'package:app_project/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_project/model/model_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class SearchScreen extends StatelessWidget {
  final int number;

  const SearchScreen({
    required this.number,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    return FutureBuilder(
      future: pageProvider.fetchItems(),
      builder: (context, snapshots) {
        if (pageProvider.pages.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.1,
              ),
              itemCount: pageProvider.pages.length,
              itemBuilder: (context, index) {
                return GridTile(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                                pageProvider.pages[index].imageUrl,
                                width: 100,
                                height: 100,
                            ),
                            Text(
                              pageProvider.pages[index].title,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    )
                );
              }
          );
        }
      },
    );
  }
}