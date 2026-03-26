import 'dart:developer';

import 'package:coladatask/features/menu/presentation/providers/menu_provider.dart';
import 'package:coladatask/features/menu/presentation/widgets/cart_bottom_bar.dart';
import 'package:coladatask/features/menu/presentation/widgets/menu_sections_body.dart';
import 'package:coladatask/features/menu/presentation/widgets/venue_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = [];
  bool _isTabTap = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(venueProvider.notifier).fetchVenue('venue_shawarmer_01');
      ref.read(catalogProvider.notifier).fetchCatalog('venue_shawarmer_01');
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isTabTap) return;
    _updateSelectedCategory();
  }

  void _updateSelectedCategory() {
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context == null) continue;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final position = box.localToGlobal(Offset.zero).dy;
      if (position <= 200) {
        final current = ref.read(selectedCategoryProvider);
        if (current != i) {
          ref.read(selectedCategoryProvider.notifier).select(i);
        }
        return;
      }
    }
  }

  void _scrollToSection(int index) {
    log(
      '_scrollToSection called with index: $index, keys: ${_sectionKeys.length}',
    );
    if (index < 0 || index >= _sectionKeys.length) {
      log('Index out of range');
      return;
    }
    final key = _sectionKeys[index];
    final keyContext = key.currentContext;
    if (keyContext == null) {
      log('Context is null for index $index');
      return;
    }

    _isTabTap = true;
    ref.read(selectedCategoryProvider.notifier).select(index);

    Scrollable.ensureVisible(
      keyContext,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    ).then((_) {
      _isTabTap = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final venueState = ref.watch(venueProvider);
    final catalogState = ref.watch(catalogProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CartBottomBar(),
      body: Column(
        children: [
          VenueHeaderSection(venueState: venueState),
          SizedBox(height: 18.h),
          Expanded(
            child: MenuSectionsBody(
              catalogState: catalogState,
              sectionKeys: _sectionKeys,
              scrollController: _scrollController,
              onTabTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}
