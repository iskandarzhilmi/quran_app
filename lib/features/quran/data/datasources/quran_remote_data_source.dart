import '../models/quran_model.dart';

abstract class QuranRemoteDataSource {
  Future<QuranModel> getQuran(int page);
}
