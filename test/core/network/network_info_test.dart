import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia/core/platform/network_info.dart';

import '../../../.fvm/flutter_sdk/dev/bots/test/common.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockDataConnectionCheaker;

  setUp(() {
    mockDataConnectionCheaker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionCheaker);
  });

  group("isConnected", () {
    test("should forward the call to DataConnectionChecker.hasConnection",
        () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(() => mockDataConnectionCheaker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      // act
      final result = networkInfoImpl.isConnected;
      // assert
      verify(() => mockDataConnectionCheaker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
