import 'package:flutter/material.dart';

class SliverSizedBox extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  const SliverSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
  });

  SliverSizedBox.fromSize({
    super.key,
    this.child,
    Size? size,
  })  : width = size?.width,
        height = size?.height;

  const SliverSizedBox.square({
    super.key,
    this.child,
    double? dimension,
  })  : width = dimension,
        height = dimension;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
