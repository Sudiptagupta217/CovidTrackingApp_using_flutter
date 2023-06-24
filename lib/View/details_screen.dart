import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  String totalCase;
  String todayCase;

  DetailsScreen({required this.name, required this.image, required this.totalCase, required this.todayCase});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage:NetworkImage(widget.image),
            ),
            Text("Total Case: "+widget.totalCase,style: TextStyle(fontSize: 20),),
            Text("Todays Case: "+widget.todayCase,style: TextStyle(fontSize: 20),)

          ],
        ),
      ),
    );
  }
}
