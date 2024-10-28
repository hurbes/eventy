import 'package:eventy/app/app.locator.dart';
import 'package:eventy/ui/views/details_form/details_form_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../data/event_data.dart';
import '../data/ticket_data.dart';
import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

void main() {
  late DetailsFormViewModel viewModel;
  late MockOrderService mockOrderService;

  setUp(() async {
    registerServices();
    mockOrderService = getAndRegisterOrderService();

    // Setup mock order service with test data
    when(mockOrderService.activeEvent).thenReturn(testEvent);
    when(mockOrderService.selectedTickets).thenReturn({testTicket1: 2});

    viewModel = DetailsFormViewModel();
  });

  tearDown(() => locator.reset());

  group('DetailsFormViewModel - Initialization', () {
    test('should initialize with correct default values', () {
      expect(viewModel.currentStep, equals(0));
      expect(viewModel.copyDetails, isFalse);
      expect(viewModel.totalAttendees, equals(2));
      expect(viewModel.event, equals(testEvent));
      expect(viewModel.selectedTickets, equals({testTicket1: 2}));
    });

    test('should calculate total price correctly', () {
      final expectedPrice = testTicket1.price! * 2;
      expect(viewModel.totalPrice, equals(expectedPrice));
    });
  });

  group('DetailsFormViewModel - Step Management', () {
    test('should handle step navigation correctly', () {
      // Initial step
      expect(viewModel.currentStep, equals(0));
      expect(viewModel.canMoveToPreviousStep(), isFalse);

      // Fill personal details to allow next step
      viewModel.updatePersonalDetails(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      );

      viewModel.nextStep();
      expect(viewModel.currentStep, equals(1));
      expect(viewModel.canMoveToPreviousStep(), isTrue);

      viewModel.previousStep();
      expect(viewModel.currentStep, equals(0));
    });

    test('should not advance step if current step is invalid', () {
      expect(viewModel.currentStep, equals(0));
      viewModel.nextStep(); // Should not advance without valid personal details
      expect(viewModel.currentStep, equals(0));
    });
  });

  group('DetailsFormViewModel - Personal Details Management', () {
    test('should update personal details correctly', () {
      viewModel.updatePersonalDetails(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      );

      expect(viewModel.personalDetails.firstName, equals('John'));
      expect(viewModel.personalDetails.lastName, equals('Doe'));
      expect(viewModel.personalDetails.email, equals('john.doe@example.com'));
      expect(viewModel.isPersonalDetailsValid, isTrue);
    });

    test('should validate personal details correctly', () {
      // Invalid details
      viewModel.updatePersonalDetails(
        firstName: '',
        lastName: 'Doe',
        email: 'invalid-email',
      );
      expect(viewModel.isPersonalDetailsValid, isFalse);

      // Valid details
      viewModel.updatePersonalDetails(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      );
      expect(viewModel.isPersonalDetailsValid, isTrue);
    });
  });

  group('DetailsFormViewModel - Attendee Details Management', () {
    test('should handle copy details correctly', () {
      // Setup valid personal details
      viewModel.updatePersonalDetails(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      );

      viewModel.setCopyDetails(true);
      expect(viewModel.copyDetails, isTrue);
      expect(
          viewModel.attendeeDetails.length, equals(viewModel.totalAttendees));
      expect(viewModel.isAttendeeDetailsValid, isTrue);
    });

    test('should update attendee details correctly', () {
      final attendeeDetails = {
        'firstName': 'Jane',
        'lastName': 'Doe',
        'email': 'jane.doe@example.com',
      };

      viewModel.updateAttendeeDetails(0, attendeeDetails);
      expect(viewModel.attendeeDetails[0], equals(attendeeDetails));
    });

    test('should validate attendee details correctly', () {
      expect(viewModel.isAttendeeDetailsValid, isFalse); // Initially empty

      // Add invalid details
      viewModel.updateAttendeeDetails(0, {
        'firstName': '',
        'lastName': 'Doe',
        'email': 'invalid-email',
      });
      expect(viewModel.isAttendeeDetailsValid, isFalse);

      // Add valid details for all attendees
      for (var i = 0; i < viewModel.totalAttendees; i++) {
        viewModel.updateAttendeeDetails(i, {
          'firstName': 'Attendee$i',
          'lastName': 'Doe',
          'email': 'attendee$i@example.com',
        });
      }
      expect(viewModel.isAttendeeDetailsValid, isTrue);
    });
  });

  group('DetailsFormViewModel - Order Processing', () {
    setUp(() {
      // Setup valid personal and attendee details
      viewModel.updatePersonalDetails(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      );

      for (var i = 0; i < viewModel.totalAttendees; i++) {
        viewModel.updateAttendeeDetails(i, {
          'firstName': 'Attendee$i',
          'lastName': 'Doe',
          'email': 'attendee$i@example.com',
        });
      }
    });

    test('should build order data correctly', () {
      final orderData = viewModel.buildOrderComplete();

      expect(orderData['order']['first_name'], equals('John'));
      expect(orderData['order']['last_name'], equals('Doe'));
      expect(orderData['order']['email'], equals('john.doe@example.com'));
      expect(orderData['attendees'].length, equals(viewModel.totalAttendees));
    });

    test('should handle order creation success', () async {
      when(mockOrderService.completeOrder(any)).thenAnswer((_) async => {});

      await viewModel.createPaymentIntent();

      verify(mockOrderService.completeOrder(any)).called(1);
    });

    test('should handle order creation failure', () async {
      when(mockOrderService.completeOrder(any))
          .thenThrow(Exception('Order creation failed'));

      await viewModel.createPaymentIntent();

      verify(mockOrderService.completeOrder(any)).called(1);
      // Verify error handling (you might want to add error state to the viewmodel)
    });
  });

  group('DetailsFormViewModel - Event Information', () {
    test('should get event image correctly', () {
      expect(viewModel.eventImage, equals(testEvent.images.first.url));
    });
  });
}
