import 'package:eventy/core/models/event/event.dart';
import 'package:objectbox/objectbox.dart';

import 'ticket_data.dart';

final testEvent = Event(
  id: 1,
  title: 'Test Event',
  description: 'A test event description',
  startDate: DateTime(2024, 4, 1, 10, 0),
  endDate: DateTime(2024, 4, 1, 18, 0),
  status: 'published',
  lifecycleStatus: 'active',
  currency: 'USD',
  timezone: 'America/New_York',
  slug: 'test-event-2024',
  images: ToMany<EventImage>(items: [testEventImage]),
  settings: ToOne<Settings>(target: testEventSettings),
  organizer: ToOne<Organizer>(target: testOrganizer),
  tickets: ToMany<Ticket>(items: [testTicket1, testTicket2]),
);

final testEventImage = EventImage(
  id: 1,
  url: 'https://example.com/image.jpg',
  size: 1024,
  fileName: 'event_image.jpg',
  mimeType: 'image/jpeg',
  type: 'header',
);

final testEventSettings = Settings(
  id: 1,
  requiredAttendeeDetails: true,
  orderTimeoutInMinutes: 30,
  homepageBodyBackgroundColor: '#FFFFFF',
  homepageBackgroundColor: '#FFFFFF',
  homepagePrimaryColor: '#000000',
  homepagePrimaryTextColor: '#FFFFFF',
  homepageSecondaryColor: '#FFFFFF',
  homepageSecondaryTextColor: '#000000',
  homepageBackgroundType: 'color',
  locationDetails: ToOne<LocationDetails>(target: testLocationDetails),
  isOnlineEvent: false,
  allowSearchEngineIndexing: true,
  notifyOrganizerOfNewOrders: true,
  hideGettingStartedPage: false,
);

final testLocationDetails = LocationDetails(
  id: 1,
  city: 'New York',
  country: 'United States',
  venueName: 'Test Venue',
  addressLine1: '123 Test Street',
  zipOrPostalCode: '10001',
);

final testOrganizer = Organizer(
  id: 1,
  name: 'Test Organizer',
  email: 'organizer@test.com',
  timezone: 'America/New_York',
  currency: 'USD',
);
