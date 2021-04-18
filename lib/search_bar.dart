import 'package:flutter/material.dart';
import 'package:flutter_bloc_simple_demo/constants.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: smallPadding, left: smallPadding),
        child: Row(children: [
          Expanded(
            flex: 9,
            child: TextField(
              controller: _searchQueryController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search cities",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.blueGrey),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: IconButton(
                key: Key('search-button'),
                icon: Icon(Icons.search),
                onPressed: (){},
              )),
        ]),
      ),
    );
  }
}