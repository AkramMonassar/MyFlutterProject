import 'package:design_home_page/DataDetailsModel.dart';
import 'package:flutter/material.dart';
import 'detailsPage.dart';

void main() {
  runApp(mainHome());
}

class mainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Design App'),
        ),
        body: SafeArea(child: PlaceDetailsPage(DataDetails.filsmpile())),
      ),
    );
  }
}
