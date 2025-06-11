// File: frontend/lib/features/dashboard/animations/fade_in_slide.dart

import 'package:flutter/material.dart';

class FadeInSlide extends StatelessWidget {
  final Widget child;
  final int delay;

  const FadeInSlide({super.key, required this.child, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, offset, widget) {
        return Opacity(
          opacity: 1.0,
          child: Transform.translate(offset: offset, child: widget),
        );
      },
      child: child,
    );
  }
}
