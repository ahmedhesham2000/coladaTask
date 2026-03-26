import 'package:coladatask/config/theme/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartAddButtonWidget extends StatelessWidget {
  final bool inCart;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onAdd;

  const CartAddButtonWidget({
    super.key,
    required this.inCart,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      alignment: Alignment.centerLeft,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[...previousChildren, ?currentChild],
          );
        },
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              axisAlignment: -1.0,
              child: child,
            ),
          );
        },
        child: inCart ? _buildQtySelector(context) : _buildAddButton(),
      ),
    );
  }

  Widget _buildQtySelector(BuildContext context) {
    return Container(
      key: const ValueKey('qty_control'),
      height: 32.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconButton(Icons.remove, onDecrement),
          SizedBox(
            width: 24.w,
            child: Center(
              child: Text(
                '$quantity',
                style: AppStyles.style50014(
                  context: context,
                  color: Colors.black87
                ),
              ),
            ),
          ),
          _buildIconButton(Icons.add, onIncrement),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      key: const ValueKey('add_button'),
      onTap: onAdd,
      child: Container(
        width: 32.h,
        height: 32.h,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Icon(Icons.add, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 32.w,
        height: 32.h,
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
    );
  }
}
