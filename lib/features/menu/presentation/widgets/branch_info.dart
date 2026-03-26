import 'package:coladatask/config/theme/app_colors.dart';
import 'package:coladatask/config/theme/font_styles.dart';
import 'package:coladatask/features/menu/domain/entities/venue.dart';
import 'package:coladatask/features/menu/presentation/widgets/change_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

class BranchInfo extends StatelessWidget {
  const BranchInfo({super.key, required this.venue});
  final VenueEntity venue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66.h,
      decoration: const BoxDecoration(
        color: Color(0xFFF9FEF7),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.only(
        top: 12.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/location.png', width: 42, height: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppStyles.style40012(context: context),
                    children: [
                      TextSpan(
                        text: 'branch_location'.tr(),
                        style: AppStyles.style40012(
                          context: context,
                          color: AppColors.textGreyDark,
                        ),
                      ),
                      TextSpan(
                        text: context.locale.languageCode == 'ar'
                            ? venue.address
                            : venue.addressEn,
                        style: AppStyles.style60012(
                          context: context,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/car_icon.svg',
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '${venue.distanceKm.toStringAsFixed(0)} ${'km'.tr()}',
                        style: AppStyles.style40012(
                          context: context,
                          color: AppColors.textGreyDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '•',
                      style: AppStyles.style40012(
                        context: context,
                        color: AppColors.textGreyDark,
                      ),
                    ),
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      'assets/icons/clock_icon.svg',
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        venue.isOpen ? venue.workingHours.label : 'closed'.tr(),
                        style: AppStyles.style40012(
                          context: context,
                          color: AppColors.textGreyDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ChangeButton(),
        ],
      ),
    );
  }
}
