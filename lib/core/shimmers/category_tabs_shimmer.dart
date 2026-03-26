import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CategoryTabsShimmer extends StatelessWidget {
  const CategoryTabsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: 5, // Shows a few "pill" placeholders
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (_, index) => Container(
            width: 80.w, // Approximate width of a category tab
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r), // Rounded "pill" shape
            ),
          ),
        ),
      ),
    );
  }
}