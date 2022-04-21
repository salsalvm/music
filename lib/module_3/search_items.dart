import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music/MAIN/widget.dart';
import 'package:music/main.dart';


class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(color: lightBlue,
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {return(
    Center(child: Text('no item found',style: TextStyle(),)));
    // final listItems = 
    // query.isEmpty
    //     ? studentListNotifier.value
    //     : studentListNotifier.value
    //         .where
    //         ((element) => element.name
    //             .toLowerCase()
    //             .startsWith(query.toLowerCase().toString()))
    //         .toList();

    // return listItems.isEmpty
    //     ? const Center(child: Text("No Data Found!"))
    //     : ListView.builder(
    //         itemCount: listItems.length,
    //         itemBuilder: (context, index) {
    //           return Padding(
    //               padding: const EdgeInsets.only(left: 15.00, right: 15.00),
    //               child: Column(
    //                 children: [
    //                   ListTile(
    //                     leading: getimage(listItems[index]),
    //                     title: Text(listItems[index].name),
    //                     subtitle: Text(
    //                         "Age : ${(listItems[index].age.toString())}"),
    //                     onTap: () {
    //                       // Navigator.of(context).push(MaterialPageRoute(
    //                       //     builder: (ctx) =>
    //                       //         HomeScreen(index: index)));
    //                     },
    //                   ),
    //                   const Divider(),
    //                 ],
    //               ));
    //         });


  }


}