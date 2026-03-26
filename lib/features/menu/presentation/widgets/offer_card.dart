import 'package:coladatask/config/theme/app_colors.dart';
import 'package:coladatask/features/menu/data/models/cart_model.dart';
import 'package:coladatask/features/menu/domain/entities/catalog.dart';
import 'package:coladatask/features/menu/presentation/providers/cart_provider.dart';
import 'package:coladatask/features/menu/presentation/widgets/cart_add_button.dart';
import 'package:coladatask/features/menu/presentation/widgets/discount_badge.dart';
import 'package:coladatask/features/menu/presentation/widgets/most_selling_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import 'package:cached_network_image/cached_network_image.dart';

class OfferCard extends ConsumerWidget {
  const OfferCard({super.key, required this.offer});
  final OfferEntity offer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider.notifier);
    ref.watch(cartProvider);
    final inCart = cart.isInCart(offer.id);
    final quantity = cart.getQuantity(offer.id);
    return SizedBox(
      // width: 144.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),

                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: offer.photo,
                      height: 144.h,
                      width: 144.w,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: AppColors.secondary,
                        ),
                      ),

                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        height: 144.h,
                        width: 144.w,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.fastfood),
                      ),
                    ),
                  ),
                ),
                if (offer.isMostSelling)
                  Positioned(top: 8, right: 8, child: MostSellingWidget()),
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  child: CartAddButtonWidget(
                    inCart: inCart,
                    quantity: quantity,
                    onIncrement: () => cart.incrementItem(offer.id),
                    onDecrement: () => cart.decrementItem(offer.id),
                    onAdd: () => cart.addItem(
                      CartModel(
                        id: offer.id,
                        name: context.locale.languageCode == 'ar'
                            ? offer.nameAr
                            : offer.nameEn,
                        quantity: 1,
                        price: offer.discountedPrice,
                        image: offer.photo,
                      ),
                    ),
                  ),
                ),

                // Helper to keep the code clean
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.locale.languageCode == 'ar' ? offer.nameAr : offer.nameEn,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (offer.discountPercent > 0)
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 6,
                      width: 50.w,
                      color: const Color(0xFFFDE272),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          offer.discountedPrice.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        SvgPicture.asset(
                          'assets/icons/currancy_icon.svg',
                          width: 12,
                          height: 12,
                          color: Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(width: 6.w),

              if (offer.discountPercent > 0)
                DiscountBadge(discountPercent: offer.discountPercent),
            ],
          ),
          // SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                offer.originalPrice.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 12,
                  color: offer.discountPercent > 0
                      ? Colors.grey.shade500
                      : Colors.black87,
                  decoration: offer.discountPercent > 0
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              if (offer.discountPercent == 0) ...[
                SizedBox(width: 2.w),
                SvgPicture.asset(
                  'assets/icons/currancy_icon.svg',
                  width: 12,
                  height: 12,
                  color: Colors.grey.shade500,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
