import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';

import 'connection_model.dart';

class ConnectionOverlay extends StackedView<ConnectionModel> {
  const ConnectionOverlay({super.key});

  @override
  Widget builder(
    BuildContext context,
    ConnectionModel viewModel,
    Widget? child,
  ) {
    return Material(
      child: Container(
        height: 80,
        color: Colors.green.shade700,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StatusIcon(isVisible: viewModel.isVisible),
            horizontalSpaceSmall,
            _StatusText(isVisible: viewModel.isVisible),
          ],
        ),
      ).animate(target: viewModel.isVisible ? 1 : 0).color(
            duration: const Duration(milliseconds: 300),
            begin: Colors.green.shade700,
            end: Colors.red.shade700,
          ),
    ).animate(target: viewModel.isVisible ? 1 : 0).fadeIn(
        duration: const Duration(milliseconds: 500),
        delay: const Duration(milliseconds: 1500));
  }

  @override
  ConnectionModel viewModelBuilder(
    BuildContext context,
  ) =>
      ConnectionModel();
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.isVisible});

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.wifi_rounded,
      color: Colors.white,
      size: 20,
    ).animate(target: isVisible ? 1 : 0).swap(
          duration: const Duration(milliseconds: 100),
          builder: (context, child) => const Icon(
            Icons.wifi_off_rounded,
            color: Colors.white,
            size: 20,
          ),
        );
  }
}

class _StatusText extends StatelessWidget {
  const _StatusText({required this.isVisible});

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Connection Restored',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ).animate(target: isVisible ? 1 : 0).swap(
          duration: const Duration(milliseconds: 100),
          builder: (context, child) => const Text(
            'No Internet Connection',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
  }
}
