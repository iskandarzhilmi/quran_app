import 'dart:convert';

import 'package:learn_hive/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quran_model.dart';

const cachedQuranKey = 'cached_quran';

abstract class QuranLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.

  Future<QuranModel> getLastQuran();

  Future<void> cacheQuran(QuranModel quranToCache);
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  final SharedPreferences sharedPreferences;

  QuranLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<QuranModel> getLastQuran() async {
    final jsonString = await sharedPreferences.getString(cachedQuranKey);
    // Future which is immediately completed
    if (jsonString != null) {
      return QuranModel.fromJson(
        jsonDecode(jsonString),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheQuran(QuranModel quranToCache) {
    return sharedPreferences.setString(
      cachedQuranKey,
      json.encode(
        quranToCache.toJson(),
      ),
    );
  }
}
