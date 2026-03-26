import 'package:coladatask/config/theme/font_styles.dart';
import 'package:coladatask/features/menu/domain/entities/catalog.dart';
import 'package:coladatask/features/menu/presentation/providers/menu_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryTabs extends ConsumerStatefulWidget {
  const CategoryTabs({super.key, required this.categories, this.onTap});
  final List<CategoryEntity> categories;
  final void Function(int index)? onTap;

  @override
  ConsumerState<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends ConsumerState<CategoryTabs> {
  final ScrollController _tabScrollController = ScrollController();
  final List<GlobalKey> _tabKeys = [];

  @override
  void dispose() {
    _tabScrollController.dispose();
    super.dispose();
  }

  void _scrollTabIntoView(int index) {
    if (index < 0 || index >= _tabKeys.length) return;
    final key = _tabKeys[index];
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedCategoryProvider);

    while (_tabKeys.length < widget.categories.length) {
      _tabKeys.add(GlobalKey());
    }

    ref.listen<int>(selectedCategoryProvider, (previous, next) {
      _scrollTabIntoView(next);
    });

    return SingleChildScrollView(
      controller: _tabScrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: widget.categories.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedIndex;
          final cat = entry.value;
          final label =
              '${context.locale.languageCode == 'ar' ? cat.nameAr : cat.nameEn}${cat.hasFireEmoji ? ' 🔥' : ''}';
          return GestureDetector(
            key: _tabKeys[entry.key],
            onTap: () {
              ref.read(selectedCategoryProvider.notifier).select(entry.key);
              widget.onTap?.call(entry.key);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 4,
                      ),
                      child: Text(
                        label,
                        style:
                            AppStyles.style40014(
                              context: context,
                              color: isSelected
                                  ? const Color(0xFF542C0D)
                                  : const Color(0xFF757575),
                            ).copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: isSelected ? 3 : 0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF542C0D),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
