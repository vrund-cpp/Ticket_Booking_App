import 'package:flutter/material.dart';

class FadeInSlide extends StatelessWidget {
  final Widget child;
  final int delay;

  const FadeInSlide({required this.child, this.delay = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (_, Offset offset, child) {
        return Opacity(
          opacity: 1,
          child: Transform.translate(offset: offset, child: child),
        );
      },
      child: child,
    );
  }
}
