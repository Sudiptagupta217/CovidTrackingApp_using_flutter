import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  String title;
  String value;
   ReusableRow({Key? key, required this.title, required this.value}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0,left: 10.0,top: 10.0,bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}
