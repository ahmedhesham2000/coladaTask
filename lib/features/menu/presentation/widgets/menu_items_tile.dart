import 'package:coladatask/core/state/base_state.dart';
import 'package:coladatask/core/shimmers/menu_items_shimmer.dart';
import 'package:coladatask/features/menu/presentation/providers/menu_provider.dart';
import 'package:coladatask/features/menu/presentation/widgets/catalog_section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemsTile extends ConsumerWidget {
  const MenuItemsTile({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogState = ref.watch(catalogProvider);
    if (catalogState.requestState == RequestState.success) {
      return Builder(
        builder: (_) {
          final catalog = catalogState.data!;
          while (sectionKeys.length < catalog.sections.length) {
            sectionKeys.add(GlobalKey());
          }
          return Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                children: [
                  for (int index = 0; index < catalog.sections.length; index++)
                    CatalogSectionWidget(
                      key: sectionKeys[index],
                      section: catalog.sections[index],
                    ),
                ],
              ),
            ),
          );
        },
      );
    } else if (catalogState.requestState == RequestState.loading ||
        catalogState.requestState == RequestState.initial) {
      return MenuItemsShimmer();
      // return Container(height: 200.h, color: Colors.grey.shade300);
    } else if (catalogState.requestState == RequestState.error) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 40.sp, color: Colors.grey),
              SizedBox(height: 8.h),
              Text(
                catalogState.errorMessage ?? 'failed_to_load_catalog'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inbox_outlined, size: 48.sp, color: Colors.grey),
              SizedBox(height: 8.h),
              Text(
                'no_items_available'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }
  }
}
