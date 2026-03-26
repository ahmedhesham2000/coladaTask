import 'package:coladatask/core/state/base_state.dart';
import 'package:coladatask/features/menu/domain/entities/catalog.dart';
import 'package:coladatask/features/menu/presentation/widgets/category_tab_tile.dart';
import 'package:coladatask/features/menu/presentation/widgets/menu_items_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuSectionsBody extends StatelessWidget {
  const MenuSectionsBody({
    super.key,
    required this.catalogState,
    required this.sectionKeys,
    required this.scrollController,
    required this.onTabTap,
  });

  final BaseState<CatalogEntity> catalogState;
  final List<GlobalKey> sectionKeys;
  final ScrollController scrollController;
  final void Function(int) onTabTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Category Tabs ──────────────────────────────────────
        CategoryTabTile(
          onTabTap: onTabTap,
          sectionKeys: sectionKeys,
          scrollController: scrollController,
        ),
        SizedBox(height: 10.h),

        // ── Menu Sections ──────────────────────────────────────
        MenuItemsTile(
          scrollController: scrollController,
          sectionKeys: sectionKeys,
        ),
      ],
    );
  }
}
