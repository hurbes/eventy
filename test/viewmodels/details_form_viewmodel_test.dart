import 'package:flutter_test/flutter_test.dart';
import 'package:eventy/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('DetailsFormViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
