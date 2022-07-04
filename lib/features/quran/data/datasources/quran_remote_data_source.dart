import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learn_hive/core/error/exception.dart';

import '../models/quran_model.dart';

abstract class QuranRemoteDataSource {
  Future<QuranModel> getQuran(int page);
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  @override
  Future<QuranModel> getQuran(int page) async {
    Response response = await Dio()
        .get('https://salamquran.com/en/api/v6/page/wbw?index=$page');

    if (response.statusCode == 200) {
      return QuranModel.fromJson(
        jsonDecode(response.data),
      );
    } else {
      throw ServerException();
    }
  }
}
