import 'package:coladatask/config/theme/app_colors.dart';
import 'package:coladatask/config/theme/font_styles.dart';
import 'package:coladatask/features/menu/presentation/providers/cart_provider.dart';
import 'package:coladatask/features/menu/presentation/widgets/cart_add_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'cart'.tr(),
          style: AppStyles.styleBold20(context: context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: cart.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'cart_empty'.tr(),
                    style: AppStyles.style50016(
                      context: context,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    itemCount: cart.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey.shade200, height: 1),
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Item image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: item.image,
                                width: 72.w,
                                height: 72.w,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),

                                errorWidget: (_, __, ___) => Container(
                                  width: 72.w,
                                  height: 72.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.fastfood,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Name + price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: AppStyles.style60016(
                                      context: context,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Text(
                                        item.price.toStringAsFixed(2),
                                        style: AppStyles.styleBold14(
                                          context: context,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      SvgPicture.asset(
                                        'assets/icons/currancy_icon.svg',
                                        width: 12,
                                        height: 12,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Quantity controls
                            CartAddButtonWidget(
                              inCart: true,
                              quantity: item.quantity,
                              onIncrement: () => ref
                                  .read(cartProvider.notifier)
                                  .incrementItem(item.id),
                              onDecrement: () => ref
                                  .read(cartProvider.notifier)
                                  .decrementItem(item.id),
                              onAdd: () {},
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Total + checkout bottom
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'total'.tr(),
                              style: AppStyles.style50014(
                                context: context,
                                color: AppColors.textGrey,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  total.toStringAsFixed(2),
                                  style: AppStyles.styleBold20(
                                    context: context,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                SvgPicture.asset(
                                  'assets/icons/currancy_icon.svg',
                                  width: 14,
                                  height: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
