import 'package:flutter/material.dart';
import 'connection_overlay.dart';

class ConnectionAwareOverlay extends StatelessWidget {
  final Widget child;

  const ConnectionAwareOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        const ConnectionOverlay(),
      ],
    );
  }
}
