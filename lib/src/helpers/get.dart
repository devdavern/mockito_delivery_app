typedef _LazyCallback<T> = T Function();

class Get {
  Get._();
  static Get i = Get._();

  final Map<String, dynamic> _data = {};
  final Map<String, _LazyCallback> _lazyData = {};

  String _getKey(Type t, String? tag) {
    if (tag != null) {
      return "${t.toString()}$tag";
    }

    return t.toString();
  }

  void put<T>(T dependency, {String? tag}) {
    final String key = _getKey(T, tag);
    _data[key] = dependency;
  }

  // ignore: library_private_types_in_public_api
  void lazyPut<T>(_LazyCallback<T> dependency, {String? tag}) {
    final String key = _getKey(T, tag);
    _lazyData[key] = dependency;
  }

  T find<T>({String? tag, bool lazy = false}) {
    final String key = _getKey(T, tag);
    final insideData = _data.containsKey(key);

    if (insideData) {
      return _data[key];
    }

    if (lazy == true) {
      if (!_lazyData.containsKey(key)) {
        throw AssertionError(
            "$key not found, make sure call ***LAZYDATA*** first");
      }

      final dependency = _lazyData[key]!();
      put<T>(dependency, tag: tag);
      return dependency;
    }

    throw AssertionError("$key not found, make sure call ***DATA*** first");
  }

  bool remove<T>({String? tag}) {
    final String key = _getKey(T, tag);

    if (_data.containsKey(key)) {
      _data.remove(key);
      return true;
    } else {
      return false;
    }
  }

  int clear() {
    final count = _data.length;
    _data.clear();
    return count;
  }

  int lazyClear() {
    final count = _lazyData.length;
    _lazyData.clear();
    return count;
  }
}
