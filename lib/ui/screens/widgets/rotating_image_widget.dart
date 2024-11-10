import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RotatingImageWidget extends StatefulWidget {
  const RotatingImageWidget(
      {super.key,
      this.imagePath = 'images/pokeball.png',
      this.isRotating = true,
      this.image});

  final String imagePath;
  final bool isRotating;
  final CachedNetworkImage? image;

  @override
  State<RotatingImageWidget> createState() => _RotatingImageWidgetState();
}

class _RotatingImageWidgetState extends State<RotatingImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (!widget.isRotating) {
            return Transform.translate(
              offset: Offset.fromDirection(2),
              child: widget.image
            );
          } else {
            return Transform.rotate(
              angle: _controller.value * 2 * 3.14,
              child: Image.asset(
                widget.imagePath,
                width: 280,
              ),
            );
          }
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
