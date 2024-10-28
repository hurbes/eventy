import 'package:eventy/core/db/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked_annotations.dart';

class ObjectboxService extends InitializableDependency {
  late final Store store;

  @override
  Future<void> init() async {
    final docsDir = await getApplicationDocumentsDirectory();
    store = await openStore(directory: p.join(docsDir.path, "eventy-spark"));
  }
}
