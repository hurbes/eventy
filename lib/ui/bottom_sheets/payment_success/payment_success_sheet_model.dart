import 'package:confetti/confetti.dart';
import 'package:stacked/stacked.dart';

class PaymentSuccessSheetModel extends BaseViewModel {
  late final ConfettiController leftConfettiController;
  late final ConfettiController centerConfettiController;
  late final ConfettiController rightConfettiController;

  PaymentSuccessSheetModel() {
    leftConfettiController = ConfettiController(
      duration: const Duration(milliseconds: 1500),
    );
    centerConfettiController = ConfettiController(
      duration: const Duration(milliseconds: 1500),
    );
    rightConfettiController = ConfettiController(
      duration: const Duration(milliseconds: 1500),
    );
  }

  void startConfetti() {
    // Stagger the start times slightly for a more natural effect
    Future.delayed(const Duration(milliseconds: 100), () {
      leftConfettiController.play();
    });
    centerConfettiController.play();
    Future.delayed(const Duration(milliseconds: 200), () {
      rightConfettiController.play();
    });
  }

  @override
  void dispose() {
    leftConfettiController.dispose();
    centerConfettiController.dispose();
    rightConfettiController.dispose();
    super.dispose();
  }
}
