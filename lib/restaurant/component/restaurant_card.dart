import 'package:flutter/material.dart';
import 'package:flutter_riverpod/common/const/colors.dart';

class RestaurantCard extends StatelessWidget {
  // 가게 사진
  final Widget image;
  // 가게 이름
  final String name;
  // 가게 태그
  final List<String> tags;
  // 평점갯수
  final int ratingCount;
  // 배달시간
  final int deliveryTime;
  // 배달비용
  final int deliveryFee;
  // 평균평점
  final double rating;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: image,
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8.0),
            Text(tags.join(" · "),
                style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0)),
            const SizedBox(height: 8.0),
            Row(
              children: [
                _IconText(icon: Icons.star, label: rating.toString()),
                renderDot(),
                _IconText(icon: Icons.receipt, label: ratingCount.toString()),
                renderDot(),
                _IconText(
                    icon: Icons.timelapse_outlined, label: "$deliveryTime분"),
                renderDot(),
                _IconText(
                    icon: Icons.monetization_on,
                    label: deliveryFee == 0 ? "무료" : deliveryFee.toString()),
              ],
            ),
          ],
        ),
      ],
    );
  }

  renderDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        "·",
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconText({
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: PRIMARY_COLOR, size: 14),
        const SizedBox(width: 8.0),
        Text(label,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500))
      ],
    );
  }
}
