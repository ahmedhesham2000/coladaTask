import 'package:coladatask/config/theme/app_colors.dart';
import 'package:coladatask/features/menu/domain/entities/venue.dart';
import 'package:coladatask/features/menu/presentation/providers/menu_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoverSection extends ConsumerWidget {
  const CoverSection({super.key, required this.venue});
  final VenueEntity venue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        SizedBox(
          height: 208.h,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: venue.coverPhoto,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(color: AppColors.secondary),
            ),

            errorWidget: (_, __, ___) => Container(
              color: Colors.grey.shade800,
              child: const Icon(Icons.image, size: 60, color: Colors.white54),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: context.locale.languageCode == 'ar' ? null : 16,
          right: context.locale.languageCode == 'ar' ? 16 : null,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: context.locale.languageCode == 'ar' ? 16 : null,
          right: context.locale.languageCode == 'ar' ? null : 16,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.language, color: Colors.black),
              onPressed: () async {
                final newLocale = context.locale.languageCode == 'ar'
                    ? const Locale('en', 'US')
                    : const Locale('ar', 'EG');

                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('language_code', newLocale.languageCode);

                if (context.mounted) {
                  await context.setLocale(newLocale);
                }

                if (context.mounted) {
                  ref.read(selectedCategoryProvider.notifier).select(0);
                  Phoenix.rebirth(context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
