import 'package:eventy/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  final int currentStep;

  const AnimatedProgressBar({
    Key? key,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                tween: Tween(
                  begin: 0,
                  end: index <= currentStep ? 1.0 : 0.0,
                ),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: ComponentColors.progressBackground,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(kcPrimaryColor),
                    minHeight: 4,
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
