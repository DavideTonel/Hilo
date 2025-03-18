import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class MemoryCard extends StatelessWidget{
  final AssetEntity photo;

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
            child: AssetEntityImage(
              photo,
              isOriginal: true,
              thumbnailSize: ThumbnailSize(size.width.toInt(), 50),
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
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
