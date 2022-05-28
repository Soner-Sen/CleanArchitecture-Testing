import 'package:firstcleanarchi/infrastructur/datasources/advicer_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'advice_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AdvicerRemoteDataSource advicerRemoteDataSource;
  late http.Client mockClient;

  setUp(() {
    mockClient = MockClient();
    advicerRemoteDataSource = AdvicerRemoteDatasourceImpl(client: mockClient);
  });
}
