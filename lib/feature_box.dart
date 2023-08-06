import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final String headerText;
  final String description;
  final Color color;
  const FeatureBox({
    super.key,
    required this.color,
    required this.headerText,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(left: 15),
        child: Column(children: [
          //HEADER
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              headerText,
              style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: 3,
          ),
          //DESCRIPTION
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              description,
              style: TextStyle(
                fontFamily: 'Cera Pro',
                color: Colors.black,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
