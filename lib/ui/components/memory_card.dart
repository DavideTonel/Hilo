import 'dart:io';

import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget{
  final File photo;

  const MemoryCard(
    {
      super.key,
      required this.photo
    }
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(   // TODO make background color
      child: Column(
        children: [
          SizedBox(
            width: size.width,
            child: Image.file(
              photo,      // or File(photo.path),
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              width: size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite
                  )
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "19/12/2000"
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
