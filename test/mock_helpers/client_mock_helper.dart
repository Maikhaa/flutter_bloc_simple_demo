// Package imports:
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:flutter_bloc_simple_demo/utils/constants.dart';
import 'client_mock_helper.mocks.dart';

@GenerateMocks([http.Client])
class ClientMockHelper{
  final mockClient = MockClient();
  final fakeCity = 'London';
  final fakeWoeid = 44418;
  final fakeLocationResponse = http.Response(KstFakeLocationResponseString, 200);
  final fakeWeatherResponse = http.Response(KstFakeWeatherResponseString, 200);

  MockClient get getMockClient {
    when(mockClient
        .get(Uri.https(kstBaseUrl, kstLocationPath, {'query': '$fakeCity'})))
        .thenAnswer((_) async => fakeLocationResponse);

    when(mockClient.get(Uri.https(kstBaseUrl, kstLocationPath, {'query': ''})))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    when(mockClient.get(Uri.https(kstBaseUrl, '/api/location/$fakeWoeid/')))
        .thenAnswer((_) async => fakeWeatherResponse);

    when(mockClient.get(Uri.https(kstBaseUrl, "/api/location/''/")))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    return mockClient;
  }
}





