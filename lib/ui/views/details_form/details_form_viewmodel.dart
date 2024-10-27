import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/services/order_service.dart';
import 'package:stacked/stacked.dart';

class DetailsFormViewModel extends ReactiveViewModel {
  final _orderService = locator<OrderService>();

  Map<Ticket, int> get selectedTickets => _orderService.selectedTickets;

  int _currentStep = 0;
  int get currentStep => _currentStep;

  bool _copyDetails = false;
  bool get copyDetails => _copyDetails;

  List<Map<String, String>> _attendeeDetails = [];
  List<Map<String, String>> get attendeeDetails => _attendeeDetails;

  void setCopyDetails(bool value) {
    _copyDetails = value;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void updateAttendeeDetails(int index, Map<String, String> details) {
    if (_attendeeDetails.length <= index) {
      _attendeeDetails.add(details);
    } else {
      _attendeeDetails[index].addAll(details);
    }
    notifyListeners();
  }

  int get totalAttendees {
    return selectedTickets.values.fold(0, (sum, count) => sum + count);
  }

  // Add event details
  final String eventImageUrl = 'https://picsum.photos/seed/event/400/200';
  final String eventName = '(NOT A) Halloween Party';
  final String eventDate = 'FRI, 01 NOV';
  final String eventTime = '07:30 PM - 10:00 PM';
  final String eventVenue = 'PLAYLYS BANGKOK';

  // Add price details
  double get totalPrice {
    return selectedTickets.entries
        .fold(0, (sum, entry) => sum + ((entry.key.price ?? 0) * entry.value));
  }
}
