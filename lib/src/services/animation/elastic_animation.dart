import 'package:flutter/material.dart';

class ElasticInAnimation extends StatefulWidget {
  final Key? key;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool animate;

  ElasticInAnimation(
      {this.key,
      required this.child,
      this.duration = const Duration(milliseconds: 650),
      this.delay = Duration.zero,
      this.animate = true})
      : super(key: key);

  @override
  _ElasticInAnimationState createState() => _ElasticInAnimationState();
}

class _ElasticInAnimationState extends State<ElasticInAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> bouncing;

  @override
  void dispose() {
    controller?.dispose();
    disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: widget.duration,
        vsync: this,
        lowerBound: 0.5,
        reverseDuration: widget.delay);
    bouncing = Tween<double>(begin: 1, end: 1.03)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.elasticIn));
    if (widget.animate) {
      Future.delayed(widget.delay, () async {
        if (!disposed && mounted) await controller?.repeat(reverse: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(scale: bouncing.value, child: widget.child);
        });
  }
}
