import 'dart:convert';

import 'package:firstcleanarchi/domain/enities/advice_entitiy.dart';
import 'package:firstcleanarchi/infrastructur/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final t_AdviceModel = AdviceModel(advice: 'test', id: 1);

  test('Model should be subclass of advice-entitiy', () {
    //assert
    //Überprüft ob es ein AdviceModel ist
    expect(t_AdviceModel, isA<AdviceEntitiy>());
  });

  group('FromJson factory', () {
    test('Should return a valid model if the Json Advice is correct', () {
      //Arrange
      //Brauchen das JSON => Mit Readerhelfer Klasse lesen wir die advice.json Datei
      final Map<String, dynamic> jsonMap = json.decode(fixture('advice.json'));

      //Act
      final result = AdviceModel.fromJson(jsonMap);

      //Assert
      expect(result, t_AdviceModel);
    });
  });
}
