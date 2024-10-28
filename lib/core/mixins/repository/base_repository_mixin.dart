import 'dart:async';
import 'package:meta/meta.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';

mixin BaseRepositoryMixin<T> on AppLogger {
  final _dataStreamController =
      StreamController<DataState<List<T>>>.broadcast();
  final _singleItemStreamController =
      StreamController<DataState<T>>.broadcast();

  Stream<DataState<List<T>>> get dataStream => _dataStreamController.stream;
  Stream<DataState<T>> get singleItemStream =>
      _singleItemStreamController.stream;

  @protected
  void emitListState(DataState<List<T>> state) {
    if (!_dataStreamController.isClosed) {
      _dataStreamController.add(state);
    }
  }

  @protected
  void emitSingleState(DataState<T> state) {
    if (!_singleItemStreamController.isClosed) {
      _singleItemStreamController.add(state);
    }
  }

  @protected
  void emitListError(Object error) {
    if (!_dataStreamController.isClosed) {
      _dataStreamController.addError(error);
    }
  }

  @protected
  void emitSingleError(Object error) {
    if (!_singleItemStreamController.isClosed) {
      _singleItemStreamController.addError(error);
    }
  }

  void dispose() {
    _dataStreamController.close();
    _singleItemStreamController.close();
  }
}
