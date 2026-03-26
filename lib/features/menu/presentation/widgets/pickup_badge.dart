import 'package:coladatask/config/theme/font_styles.dart';
import 'package:coladatask/features/menu/presentation/widgets/wave_clipper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

class PickupBadge extends StatelessWidget {
  const PickupBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(120.w, 30.h),
      painter: PickupTagPainter(
        color: const Color(0xFFF9FEF7),
        isArabic: context.locale.languageCode == 'ar',
      ),
      child: Container(
        width: 120.w,
        height: 30.h,
        padding: EdgeInsets.only(
          left: context.locale.languageCode == 'ar' ? 0 : 20.w,
          right: context.locale.languageCode == 'ar' ? 20.w : 0,
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: SvgPicture.asset(
                'assets/icons/pickup_from_icon.svg',
                width: 16,
                height: 16,
              ),
            ),
            Text(
              'pickup_from_branch'.tr(),
              style: AppStyles.style40012(
                context: context,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
