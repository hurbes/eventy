import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/services/order_service.dart';

import 'package:stacked/stacked.dart';

class DetailsFormViewModel extends FutureViewModel<void> with AppLogger {
  final _orderService = locator<OrderService>();

  Event? get event => _orderService.activeEvent;
  Map<Ticket, int> get selectedTickets => _orderService.selectedTickets;

  int _currentStep = 0;
  int get currentStep => _currentStep;

  bool _copyDetails = false;
  bool get copyDetails => _copyDetails;

  final PersonalDetails _personalDetails = PersonalDetails();
  PersonalDetails get personalDetails => _personalDetails;

  final List<Map<String, String>> _attendeeDetails = [];
  List<Map<String, String>> get attendeeDetails => _attendeeDetails;

  void setCopyDetails(bool value) {
    _copyDetails = value;
    if (value && isPersonalDetailsValid) {
      // Copy personal details to all attendees
      _attendeeDetails.clear();
      for (var i = 0; i < totalAttendees; i++) {
        _attendeeDetails.add(_personalDetails.toMap());
      }
    }
    notifyListeners();
  }

  bool canMoveToNextStep() {
    return isCurrentStepValid();
  }

  bool canMoveToPreviousStep() {
    return _currentStep > 0;
  }

  void nextStep() {
    if (_currentStep < 2 && canMoveToNextStep()) {
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

  void updatePersonalDetails({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) {
    if (firstName != null) _personalDetails.firstName = firstName;
    if (lastName != null) _personalDetails.lastName = lastName;
    if (email != null) _personalDetails.email = email;

    // Update first attendee details as well
    updateAttendeeDetails(0, _personalDetails.toMap());
    notifyListeners();
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

  double get totalPrice {
    return selectedTickets.entries
        .fold(0, (sum, entry) => sum + ((entry.key.price ?? 0) * entry.value));
  }

  // Validation getters
  bool get isPersonalDetailsValid => _personalDetails.isValid;

  bool get isAttendeeDetailsValid {
    if (_attendeeDetails.isEmpty) return false;

    // If copyDetails is true, we only need to validate personal details
    if (copyDetails) return isPersonalDetailsValid;

    // Check if we have details for all attendees
    if (_attendeeDetails.length != totalAttendees) return false;

    // Validate each attendee's details
    return _attendeeDetails.every((details) {
      final attendee = PersonalDetails(
        firstName: details['firstName'],
        lastName: details['lastName'],
        email: details['email'],
      );
      // Note: Phone is not required for additional attendees
      return attendee.firstName?.isNotEmpty == true &&
          attendee.lastName?.isNotEmpty == true &&
          PersonalDetails.isValidEmail(attendee.email ?? '');
    });
  }

  String get eventImage {
    if (event?.images.isEmpty == true) return '';
    return event!.images.first.url;
  }

  bool isCurrentStepValid() {
    switch (_currentStep) {
      case 0:
        return isPersonalDetailsValid;
      case 1:
        return isAttendeeDetailsValid;
      case 2:
        return true;
      default:
        return false;
    }
  }

  void changeStep() {
    if (currentStep < 2 && canMoveToNextStep()) {
      return nextStep();
    }
    if (isCurrentStepValid()) {
      createPaymentIntent();
    }
  }

  Future<void> createPaymentIntent() async {
    try {
      final orderData = buildOrderComplete();
      await _orderService.completeOrder(orderData);
    } catch (e) {
      logE(e.toString());
    }
  }

  Map<String, dynamic> buildOrderComplete() {
    // Build attendees list based on selected tickets
    final List<Map<String, dynamic>> attendeesList = [];

    var attendeeIndex = 0;
    for (final ticketEntry in selectedTickets.entries) {
      final ticket = ticketEntry.key;
      final quantity = ticketEntry.value;

      // Create attendee entries for each ticket quantity
      for (var i = 0; i < quantity; i++) {
        if (attendeeIndex < _attendeeDetails.length) {
          attendeesList.add({
            'ticket_price_id': ticket.prices.first.id,
            'first_name': _attendeeDetails[attendeeIndex]['firstName'],
            'last_name': _attendeeDetails[attendeeIndex]['lastName'],
            'email': _attendeeDetails[attendeeIndex]['email'],
            'ticket_id': ticket.id,
          });
          attendeeIndex++;
        }
      }
    }

    // Build the complete order structure
    return {
      'order': {
        'first_name': _personalDetails.firstName,
        'last_name': _personalDetails.lastName,
        'email': _personalDetails.email,
      },
      'attendees': attendeesList,
      'address': {},
      "questions": [],
    };
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];

  @override
  bool get enableLogs => true;

  @override
  Future<void> futureToRun() => _orderService.createOrder();
}
