import 'package:flutter/material.dart';

class ButtonAnimation extends StatefulWidget {
  final Widget child;
  final Color highLightColor;
  final Color splashColor;
  final Color color;
  final double elevation;
  final Color focusColor;
  final VoidCallback? onPressed;
  final RoundedRectangleBorder border;

  const ButtonAnimation({
    Key? key,
    required this.child,
    required this.highLightColor,
    required this.border,
    required this.color,
    required this.splashColor,
    required this.elevation,
    required this.focusColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<ButtonAnimation> createState() => _ButtonAnimationState();
}

class _ButtonAnimationState extends State<ButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.9,
      upperBound: 1.1,
    );

    _controller.value = Curves.elasticOut.transform(_controller.value);
    _controller.animateTo(1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: RawMaterialButton(
        onPressed: widget.onPressed,
        shape: widget.border,
        elevation: widget.elevation,
        highlightElevation: 0,
        focusColor: widget.focusColor,
        highlightColor: widget.highLightColor,
        fillColor: widget.color,
        splashColor: widget.splashColor,
        child: widget.child,
        onHighlightChanged: (value) {
          if (value) {
            setState(() {
              _controller.forward();
            });
          } else {
            setState(() {
              _controller.reverse();
            });
          }
        },
      ),
    );
  }
}
