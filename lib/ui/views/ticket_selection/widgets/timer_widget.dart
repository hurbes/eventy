import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/shared/animated_flip_counter.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 1), (i) => 15 * 60 - i)
          .take(15 * 60),
      builder: (context, snapshot) {
        final seconds = snapshot.data ?? 15 * 60;
        final minutes = seconds ~/ 60;
        final remainingSeconds = seconds % 60;

        Color timerColor;
        if (seconds > 10 * 60) {
          timerColor = ComponentColors.timerNormal;
        } else if (seconds > 5 * 60) {
          timerColor = ComponentColors.timerWarning;
        } else {
          timerColor = ComponentColors.timerCritical;
        }

        return Row(
          children: [
            AnimatedFlipCounter(
              value: minutes,
              textStyle: GoogleFonts.inter(
                color: timerColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ':',
              style: GoogleFonts.inter(
                color: timerColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedFlipCounter(
              value: remainingSeconds,
              textStyle: GoogleFonts.inter(
                color: timerColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              wholeDigits: 2,
            ),
          ],
        );
      },
    );
  }
}
