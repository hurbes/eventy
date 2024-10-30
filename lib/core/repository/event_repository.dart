import 'package:eventy/core/db/objectbox.g.dart';
import 'package:eventy/core/interfaces/i_database_service.dart';
import 'package:eventy/core/models/event/event.dart';

import 'app_repository.dart';

class EventRepository extends Repository<Event> {
  EventRepository() : super();

  @override
  Event parseItem(Map<String, dynamic> json) => Event.fromJson(json);

  @override
  List<Event> parseList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Event.fromJson(json)).toList();
  }

  @override
  int getItemId(Event item) => item.id ?? 0;

  @override
  FindAllHelper<Event, Store> get findAllHelper => _findAll;

  Future<List<Event>> _findAll(Store store) async {
    final box = store.box<Event>().query();
    box.linkMany(Event_.images);

    Query<Event> query = box.build();
    logI('New ids query');
    return query.find();
  }

  @override
  bool get enableLogs => true;
}
