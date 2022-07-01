import '../models/quran_model.dart';

abstract class QuranLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<QuranModel> getLastQuran();

  Future<void> cacheQuran(QuranModel quranToCache);
}
