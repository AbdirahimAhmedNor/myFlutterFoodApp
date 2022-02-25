import 'package:flutter/material.dart';
import 'package:food_app/pages/food_detail.dart';
import 'package:food_app/theme/color.dart';

import 'favorite_box.dart';

class PopularItem extends StatelessWidget {
  PopularItem({Key? key, required this.data}) : super(key: key);
  final data;
  @override
  Widget build(BuildContext context) {
    print(data['price'].runtimeType);
    return Container(
      margin: EdgeInsets.only(right: 15),
      height: 170, width: 220,
      // color: secondary,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            child: GestureDetector(
              child: Container(
                height: 120,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(data["imageUrl"])),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailScreen(data: data),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 140,
            child: Container(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        data["name"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$ ${data["price"].toString()}',
                        style: TextStyle(
                            fontSize: 14,
                            color: primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
