import 'dart:collection';

class LRUCache<K, V> {
  final int maxSize;
  final LinkedHashMap<K, V> _cache = LinkedHashMap();

  LRUCache(this.maxSize);

  V? get(K key) {
    if (!_cache.containsKey(key)) return null;
    final value = _cache.remove(key);
    _cache[key] = value as V;
    return value;
  }

  void put(K key, V value) {
    if (_cache.containsKey(key)) _cache.remove(key);
    _cache[key] = value;
    if (_cache.length > maxSize) _cache.remove(_cache.keys.first);
  }

  void clear() => _cache.clear();

  void remove(K key) {
    _cache.remove(key);
  }
}
