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
    // First remove any existing entry with the same key
    if (_cache.containsKey(key)) {
      _cache.remove(key);
    } else {
      // If the value already exists somewhere else, remove that entry
      K? keyToRemove;
      _cache.forEach((k, v) {
        if (v == value) {
          keyToRemove = k;
        }
      });
      if (keyToRemove != null) {
        _cache.remove(keyToRemove);
      }
    }

    // Add the new key-value pair
    _cache[key] = value;

    // Remove oldest entry if cache exceeds maxSize
    if (_cache.length > maxSize) {
      _cache.remove(_cache.keys.first);
    }
  }

  void clear() => _cache.clear();

  void remove(K key) {
    _cache.remove(key);
  }
}
