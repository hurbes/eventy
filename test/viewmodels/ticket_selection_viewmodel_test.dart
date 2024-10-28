import 'package:flutter_test/flutter_test.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/ui/views/ticket_selection/ticket_selection_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../data/event_data.dart';
import '../data/ticket_data.dart';
import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

void main() {
  late TicketSelectionViewModel viewModel;
  late MockOrderService mockOrderService;

  setUp(() {
    registerServices();
    mockOrderService = getAndRegisterOrderService();

    // Setup mock order service with test data
    when(mockOrderService.activeEvent).thenReturn(testEvent);
    when(mockOrderService.selectedTickets).thenReturn({});
    when(mockOrderService.quantityForTicket(any)).thenReturn(0);
    when(mockOrderService.canAddMoreTickets(any)).thenReturn(true);
    when(mockOrderService.canRemoveTickets(any)).thenReturn(false);

    viewModel = TicketSelectionViewModel();
  });

  tearDown(() => locator.reset());

  group('TicketSelectionViewModel - Initialization', () {
    test('should initialize with correct event data', () {
      expect(viewModel.event, equals(testEvent));
      expect(viewModel.tickets, equals(testEvent.tickets));
      expect(viewModel.selectedTickets, isEmpty);
      expect(viewModel.hasSelectedTickets, isFalse);
    });

    test('should get event image correctly', () {
      expect(viewModel.eventImage, equals(testEvent.images.first.url));
    });
  });

  group('TicketSelectionViewModel - Ticket Management', () {
    test('should get correct quantity for ticket', () {
      // Arrange
      when(mockOrderService.quantityForTicket(testTicket1)).thenReturn(2);

      // Act & Assert
      expect(viewModel.quantityForTicket(testTicket1), equals(2));
      verify(mockOrderService.quantityForTicket(testTicket1)).called(1);
    });

    test('should check if can add more tickets', () {
      // Arrange
      when(mockOrderService.canAddMoreTickets(testTicket1)).thenReturn(true);

      // Act & Assert
      expect(viewModel.canAddMoreTickets(testTicket1), isTrue);
      verify(mockOrderService.canAddMoreTickets(testTicket1)).called(1);
    });

    test('should check if can remove tickets', () {
      // Arrange
      when(mockOrderService.canRemoveTickets(testTicket1)).thenReturn(true);

      // Act & Assert
      expect(viewModel.canRemoveTickets(testTicket1), isTrue);
      verify(mockOrderService.canRemoveTickets(testTicket1)).called(1);
    });

    test('should add ticket correctly', () {
      // Act
      viewModel.addTicket(testTicket1);

      // Assert
      verify(mockOrderService.addTicket(testTicket1)).called(1);
    });

    test('should remove ticket correctly', () {
      // Act
      viewModel.removeTicket(testTicket1);

      // Assert
      verify(mockOrderService.removeTicket(testTicket1)).called(1);
    });
  });

  group('TicketSelectionViewModel - Navigation', () {
    test('should not navigate when no tickets selected', () {
      // Arrange
      when(mockOrderService.selectedTickets).thenReturn({});

      // Act
      viewModel.navigateToDetailsForm();
    });

    test('should not navigate when selected tickets have zero quantity', () {
      // Arrange
      when(mockOrderService.selectedTickets).thenReturn({testTicket1: 0});

      // Act
      viewModel.navigateToDetailsForm();
    });

    test('should navigate when tickets are selected', () {
      // Arrange
      when(mockOrderService.selectedTickets).thenReturn({testTicket1: 2});

      // Act
      viewModel.navigateToDetailsForm();
    });
  });

  group('TicketSelectionViewModel - Reactive Updates', () {
    test('should update when order service changes', () {
      // Verify that OrderService is in listenableServices
      expect(viewModel.listenableServices, contains(mockOrderService));
    });

    test('should reflect changes in selected tickets', () {
      // Arrange
      final updatedSelection = {testTicket1: 2};
      when(mockOrderService.selectedTickets).thenReturn(updatedSelection);

      // Act & Assert
      expect(viewModel.selectedTickets, equals(updatedSelection));
      expect(viewModel.hasSelectedTickets, isTrue);
    });

    test('should reflect changes in ticket availability', () {
      // Arrange
      when(mockOrderService.canAddMoreTickets(testTicket1)).thenReturn(false);
      when(mockOrderService.canRemoveTickets(testTicket1)).thenReturn(true);

      // Act & Assert
      expect(viewModel.canAddMoreTickets(testTicket1), isFalse);
      expect(viewModel.canRemoveTickets(testTicket1), isTrue);
    });
  });

  group('TicketSelectionViewModel - Validation', () {
    test('should correctly determine if has selected tickets', () {
      // No tickets selected
      when(mockOrderService.selectedTickets).thenReturn({});
      expect(viewModel.hasSelectedTickets, isFalse);

      // Tickets selected with zero quantity
      when(mockOrderService.selectedTickets).thenReturn({testTicket1: 0});
      expect(viewModel.hasSelectedTickets, isFalse);

      // Tickets selected with positive quantity
      when(mockOrderService.selectedTickets).thenReturn({testTicket1: 1});
      expect(viewModel.hasSelectedTickets, isTrue);
    });
  });
}
