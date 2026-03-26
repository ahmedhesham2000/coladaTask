import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

class MostSellingWidget extends StatelessWidget {
  const MostSellingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9EC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/most_selling_icon.svg',
            width: 14,
            height: 14,
          ),
          SizedBox(width: 4.w),
          Text(
            'most_selling'.tr(),
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF4CAF50),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
