import 'dart:async';

import 'package:flutter/material.dart';

class MyScaleAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final int duration;
  const MyScaleAnimation({
    super.key,
    required this.delay,
    required this.child,
    required this.duration,
  });

  @override
  State<MyScaleAnimation> createState() => _MyScaleAnimationState();
}

class _MyScaleAnimationState extends State<MyScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
