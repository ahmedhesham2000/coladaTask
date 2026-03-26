import 'package:coladatask/config/theme/font_styles.dart';
import 'package:coladatask/features/menu/domain/entities/catalog.dart';
import 'package:coladatask/features/menu/presentation/widgets/menu_item_tile.dart';
import 'package:coladatask/features/menu/presentation/widgets/offer_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

class CatalogSectionWidget extends StatelessWidget {
  const CatalogSectionWidget({super.key, required this.section});
  final CatalogSectionEntity section;

  @override
  Widget build(BuildContext context) {
    final hasOffers = section.offers.isNotEmpty;

    return Stack(
      children: [
        if (hasOffers)
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/offers_bg.svg',
              fit: BoxFit.fill,
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section Title ---
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 4.h),
              child: Row(
                children: [
                  Text(
                    context.locale.languageCode == 'ar'
                        ? section.category.nameAr
                        : section.category.nameEn,
                    style: AppStyles.styleBold18(context: context),
                  ),
                  if (section.category.hasFireEmoji) const Text(' 🔥'),
                ],
              ),
            ),

            // --- Grid for Offers ---
            if (hasOffers) ...[
              SizedBox(height: 16.h),
              SizedBox(
                height: 260.h,

                child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  padding: EdgeInsets.symmetric(horizontal: 16.w),

                  itemCount: section.offers.length,

                  separatorBuilder: (_, _) => SizedBox(width: 12.w),

                  itemBuilder: (_, i) => OfferCard(offer: section.offers[i]),
                ),
              ),
            ],

            if (hasOffers && section.items.isNotEmpty) SizedBox(height: 16.h),

            // --- List for Normal Items ---
            if (section.items.isNotEmpty)
              ...section.items.map((item) => MenuItemTile(item: item)),
          ],
        ),
      ],
    );
  }
}
