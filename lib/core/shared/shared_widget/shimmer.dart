
import 'package:flutter/material.dart';
import'package:shimmer/shimmer.dart';

shimmerListHorizontalEffect({double height = 120, double width = 115}) {
  return Container(
    height: height,
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: ListView.separated(
      //shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[200]!,
          child: Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10.0);
      },
      itemCount: 6,
    ),
  );
}

