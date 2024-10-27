import 'package:eventy/core/models/event/event.dart';

import 'app_repository.dart';

class EventRepository extends Repository<Event> {
  EventRepository() : super();

  @override
  Event parseItem(Map<String, dynamic> json) => Event.fromJson(json['data']);

  @override
  List<Event> parseList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Event.fromJson(json)).toList();
  }

  @override
  String getItemId(Event item) => item.id?.toString() ?? '';

  @override
  bool get enableLogs => true;
}
