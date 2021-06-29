import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final String title;
  const TagWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow,
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(title),
          Container(
            height: 30,
            width: 30,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
              iconSize: 15,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
