import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

// ignore: must_be_immutable
class ItemGlassCard extends StatelessWidget {
  final Widget child;

  const ItemGlassCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorUtils.appColorWhite.withValues(alpha: 0.0),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: ColorUtils.appColorWhite.withValues(alpha: 0.3),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: child,
          ),
      ),
    );
  }
}
