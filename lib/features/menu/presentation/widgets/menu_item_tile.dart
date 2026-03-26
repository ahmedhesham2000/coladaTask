import 'package:coladatask/config/theme/app_colors.dart';
import 'package:coladatask/config/theme/font_styles.dart';
import 'package:coladatask/features/menu/data/models/cart_model.dart';
import 'package:coladatask/features/menu/domain/entities/catalog.dart';
import 'package:coladatask/features/menu/presentation/providers/cart_provider.dart';
import 'package:coladatask/features/menu/presentation/widgets/cart_add_button.dart';
import 'package:coladatask/features/menu/presentation/widgets/discount_badge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import 'package:cached_network_image/cached_network_image.dart';

class MenuItemTile extends ConsumerWidget {
  const MenuItemTile({super.key, required this.item});
  final MenuItemEntity item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider.notifier);
    ref.watch(cartProvider);
    final inCart = cart.isInCart(item.id);
    final quantity = cart.getQuantity(item.id);
    final isAr = context.locale.languageCode == 'ar';
    final name = isAr ? item.nameAr : item.nameEn;
    final description = isAr ? item.descriptionAr : item.descriptionEn;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppStyles.styleBold14(
                        context: context,
                        color: AppColors.textBlack,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.style40014(
                        context: context,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            if (item.hasDiscount)
                              Container(
                                height: 6.h,
                                width: 45.w,
                                color: const Color(0xFFFDE272),
                              ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  ' ${item.sellingPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: item.hasDiscount
                                        ? AppColors.textGreen
                                        : AppColors.textBlack,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                SvgPicture.asset(
                                  'assets/icons/currancy_icon.svg',
                                  width: 12,
                                  height: 12,
                                  color: item.hasDiscount
                                      ? AppColors.textGreen
                                      : AppColors.textBlack,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 4.w),
                        if (item.hasDiscount)
                          Text(
                            item.originalPrice.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        SizedBox(width: 4.w),
                        if (item.hasDiscount) ...[
                          DiscountBadge(discountPercent: item.discountPercent),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: item.photo,
                      width: 144.w,
                      height: 144.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: AppColors.secondary,
                        ),
                      ),

                      errorWidget: (_, __, ___) => Container(
                        width: 144.w,
                        height: 144.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.fastfood),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6.h,
                    left: 6.w,
                    child: CartAddButtonWidget(
                      inCart: inCart,
                      quantity: quantity,
                      onIncrement: () => cart.incrementItem(item.id),
                      onDecrement: () => cart.decrementItem(item.id),
                      onAdd: () => cart.addItem(
                        CartModel(
                          id: item.id,
                          image: item.photo,
                          nameAr: item.nameAr,
                          nameEn: item.nameEn,
                          quantity: 1,
                          price: item.hasDiscount
                              ? item.sellingPrice
                              : item.originalPrice,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey.shade200,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
