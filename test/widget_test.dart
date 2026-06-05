import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yusry/main.dart';

void main() {
  testWidgets('renders e-commerce splash, home and details screens', (WidgetTester tester) async {
    await HttpOverrides.runZoned(() async {
      // Set viewport size using modern tester.view API
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      // 1. Render App and verify Splash Screen
      await tester.pumpWidget(const BasicNavigationApp());
      expect(find.text('Siddiq SHOP'), findsOneWidget);
      expect(find.text('Preparing a premium shopping experience...'), findsOneWidget);

      // 2. Trigger timer and navigate to HomeScreen
      await tester.pump(const Duration(milliseconds: 1800));
      await tester.pump(const Duration(milliseconds: 600));

      // Verify HomeScreen elements
      expect(find.text('Siddiq SHOP'), findsOneWidget);
      expect(find.text('Categories'), findsOneWidget);
      expect(find.text('Explore Products'), findsOneWidget);

      // Verify product presence
      expect(find.text('AcousticMax Pro Headphones'), findsOneWidget);
      expect(find.text('SpeedRun Trail Sneakers'), findsOneWidget);

      final headphoneFinder = find.text('AcousticMax Pro Headphones');
      await tester.ensureVisible(headphoneFinder);
      await tester.pump(const Duration(milliseconds: 600));

      // 3. Tap on a product to navigate to DetailsScreen
      await tester.tap(headphoneFinder);
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      // Verify DetailsScreen elements using skipOffstage: false
      expect(find.text('ELECTRONICS', skipOffstage: false), findsOneWidget);
      expect(find.text('Description', skipOffstage: false), findsOneWidget);
      expect(find.text('Add To Cart', skipOffstage: false), findsOneWidget);
      expect(find.text('Buy Now', skipOffstage: false), findsOneWidget);

      // 4. Tap Back button
      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded, skipOffstage: false));
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      // Verify back on HomeScreen
      expect(find.text('Explore Products'), findsOneWidget);
    }, createHttpClient: (context) => _MockHttpClient());
  });
}

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient implements HttpClient {
  @override
  int? maxConnectionsPerHost;
  @override
  Future<ConnectionTask<Socket>> Function(Uri url, String? scheme, int? port)? connectionFactory;
  @override
  set keyLog(Function(String line)? callback) {}
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #getUrl ||
        invocation.memberName == #openUrl ||
        invocation.memberName == #get) {
      return Future.value(_MockHttpClientRequest());
    }
    return null;
  }
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  void addError(Object error, [StackTrace? stackTrace]) {}
  @override
  void abort([Object? exception, StackTrace? stackTrace]) {}
  @override
  String get method => 'GET';
  @override
  Uri get uri => Uri.parse('http://dummy');
  @override
  Future flush() async {}
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #close) {
      return Future.value(_MockHttpClientResponse());
    }
    if (invocation.memberName == #headers) {
      return _MockHttpHeaders();
    }
    return null;
  }
}

class _MockHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _MockHttpClientResponse implements HttpClientResponse {
  static final List<int> _transparentImage = [
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
    0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
    0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
    0x42, 0x60, 0x82
  ];
  @override
  X509Certificate? get certificate => null;
  @override
  HttpConnectionInfo? get connectionInfo => null;
  @override
  bool get persistentConnection => true;
  @override
  HttpClientResponseCompressionState get compressionState => HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentImage]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #statusCode) return 200;
    if (invocation.memberName == #reasonPhrase) return 'OK';
    if (invocation.memberName == #contentLength) return _transparentImage.length;
    if (invocation.memberName == #headers) return _MockHttpHeaders();
    if (invocation.memberName == #persistentConnectionState) return null;
    return null;
  }
}
