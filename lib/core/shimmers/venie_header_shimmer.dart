import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VenueHeaderShimmer extends StatelessWidget {
  const VenueHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Cover Image Skeleton
          Container(
            height: 200.h,
            width: double.infinity,
            color: Colors.white,
          ),
          
          // 2. Info Card Skeleton
          Padding(
            padding: EdgeInsets.only(top: 150.h),
            child: Container(
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              // Optional: Add lines inside the card for name/rating
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 150.w, height: 16.h, color: Colors.white),
                  SizedBox(height: 10.h),
                  Container(width: 100.w, height: 12.h, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}