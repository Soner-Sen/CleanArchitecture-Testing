import 'dart:convert';

import '../../domain/enities/advice_entitiy.dart';
import 'package:http/http.dart' as http;

import '../models/advice_model.dart';

abstract class AdvicerRemoteDataSource {
  Future<AdviceEntitiy> getRandomAdviceFromApi();
}

class AdvicerRemoteDatasourceImpl implements AdvicerRemoteDataSource {
  final http.Client client;
  AdvicerRemoteDatasourceImpl({required this.client});

  @override
  Future<AdviceEntitiy> getRandomAdviceFromApi() async {
    final response =
        await client.get(Uri.parse('https://api.adviceslip.com/advice'));

    final responseBody = json.decode(response.body);
    return AdviceModel.fromJson(responseBody['slip']);
  }
}
