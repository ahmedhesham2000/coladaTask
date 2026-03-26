import 'package:coladatask/config/theme/font_styles.dart';
import 'package:coladatask/features/menu/presentation/providers/cart_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class CartBottomBar extends ConsumerWidget {
  const CartBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    if (cart.isEmpty) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => context.push('/cart'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFAC515),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: const Color(0xffeaaa08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFEAAA08)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${cart.fold<int>(0, (sum, item) => sum + item.quantity)}',
                  style: AppStyles.styleBold16(
                    context: context,
                  ).copyWith(color: const Color(0xFF542C0D)),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'pickup_order_summary'.tr(),
                  style: AppStyles.styleBold16(context: context),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ref.watch(cartTotalProvider).toStringAsFixed(2),
                    style: AppStyles.styleBold16(context: context),
                  ),
                  SizedBox(width: 4.w),
                  SvgPicture.asset(
                    'assets/icons/currancy_icon.svg',
                    width: 14,
                    height: 14,
                    color: const Color(0xFF542C0D),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: const Color(0xFF542C0D),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
