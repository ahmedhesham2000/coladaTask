import 'package:coladatask/config/theme/app_colors.dart';
import 'package:coladatask/config/theme/font_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangeButton extends StatelessWidget {
  const ChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: RichText(
          text: TextSpan(
            style: AppStyles.style60013(
              context: context,
              color: AppColors.textGreen,
            ),
            children: [
              TextSpan(
                text: 'change'.tr().substring(0, 2),
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
              TextSpan(text: 'change'.tr().substring(2)),
            ],
          ),
        ),
      ),
    );
  }
}
