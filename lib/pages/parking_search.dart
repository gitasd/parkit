import 'dart:ffi';

import 'package:flutter/material.dart';

class SearchParking extends SearchDelegate<String> {
  SearchParking({required this.locationslist});
  Set<dynamic> locationslist;

  final recentParkings = [
    'Jalandhar',
    'Biswan',
    'Jhansi',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
          onPressed: () {
            !query.isEmpty ? query = "" : close(context, '');
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // search suggestions when someone searches for anything
    final suggestionList = query.isEmpty
        // ? recentParkings
        ? locationslist.toList()
        : locationslist
            .toList()
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          close(context, query);
          // close(context, suggestionList[index]);
        },
        leading: Icon(Icons.local_parking),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              )
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
