import 'package:coladatask/config/theme/app_colors.dart';
import 'package:coladatask/config/theme/font_styles.dart';
import 'package:coladatask/features/menu/domain/entities/venue.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import 'package:cached_network_image/cached_network_image.dart';

class VenueHeader extends StatelessWidget {
  const VenueHeader({super.key, required this.venue});
  final VenueEntity venue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: venue.logo,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(color: AppColors.secondary),
              ),

              errorWidget: (_, __, ___) => const Icon(Icons.store, size: 30),
            ),
          ),
        ),

        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                context.locale.languageCode == 'ar' ? venue.nameAr : venue.name,
                style: AppStyles.style60016(
                  context: context,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/rate_icon.svg',
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    venue.rating.toStringAsFixed(1),
                    style: AppStyles.styleBold14(
                      context: context,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(width: 8.w),

                  Text(
                    '(${venue.reviewCount}+)',
                    style: AppStyles.styleRegular12(
                      context: context,
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Image.asset(
                    'assets/icons/location_pin_icon.png',
                    width: 14,
                    height: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
