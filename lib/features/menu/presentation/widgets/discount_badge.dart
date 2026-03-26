import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({super.key, required this.discountPercent});
  final int discountPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4E3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$discountPercent%',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(width: 2.w),
          SvgPicture.asset(
            'assets/icons/discount_icon.svg',
            width: 12,
            height: 12,
          ),
        ],
      ),
    );
  }
}
