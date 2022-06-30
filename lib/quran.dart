import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> getQuran() async {
  var url = Uri.parse('https://salamquran.com/en/api/v6/page/wbw?index=3');
  var response = await http.get(url);
  var jsonResponse = jsonDecode(response.body);
  var data = (jsonResponse['result'] ?? []) as List;

  return data;
}
