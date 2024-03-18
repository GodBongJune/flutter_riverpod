import 'package:flutter/material.dart';
import 'package:flutter_riverpod/common/const/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/img/food/ddeok_bok_gi.jpg",
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "떡볶이",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  "전통 떡볶이의 정석! 원하는대로 맵기를 선택하고 추억의 떡볶이맛에 빠져보세요! 쫀득한 쌀떡과 말랑한 오뎅의 완벽한 조화! 잘익은 반숙 계란은 덤!",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
                ),
                Text(
                  "₩10000",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
