import 'package:coladatask/core/shimmers/category_tabs_shimmer.dart';
import 'package:coladatask/core/state/base_state.dart';
import 'package:coladatask/features/menu/presentation/providers/menu_provider.dart';
import 'package:coladatask/features/menu/presentation/widgets/category_tabs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryTabTile extends ConsumerWidget {
  const CategoryTabTile({
    super.key,
    required this.onTabTap,
    required this.sectionKeys,
    required this.scrollController,
  });

  final void Function(int) onTabTap;
  final List<GlobalKey> sectionKeys;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogState = ref.watch(catalogProvider);

    if (catalogState.requestState == RequestState.success) {
      return CategoryTabs(
        categories: catalogState.data!.categories,
        onTap: onTabTap,
      );
    } else if (catalogState.requestState == RequestState.loading ||
        catalogState.requestState == RequestState.initial) {
      return const CategoryTabsShimmer();
    } else if (catalogState.requestState == RequestState.error) {
      return Container(
        height: 50.h,
        color: Colors.grey.shade300,
        child: Center(
          child: Text(
            catalogState.errorMessage ?? 'failed_to_load_catalog'.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
