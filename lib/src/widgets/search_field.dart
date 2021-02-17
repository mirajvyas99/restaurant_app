import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.white,
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: TextField(
        decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        hintText: "Search food",
        suffixIcon: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        border: InputBorder.none,
        ),
      ),
    );
  }
}
