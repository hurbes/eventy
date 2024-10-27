import 'package:eventy/core/models/event/event.dart';
import 'package:stacked/stacked.dart';

class EventCardModel extends BaseViewModel {
  final Event event;

  EventCardModel({required this.event});

  bool get isUpcoming {
    return event.startDate.isAfter(DateTime.now());
  }

  String get eventTitle {
    return event.title;
  }

  String get eventLocation {
    return event.settings.target?.locationDetails.target?.venueName ?? '';
  }

  String get eventImage {
    if (event.images.isEmpty) return '';
    return event.images.first.url;
  }

  String get eventDescription {
    return event.description;
  }

  String get eventDate {
    return event.startDate.toIso8601String();
  }
}
