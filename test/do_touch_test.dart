import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:do_touch/do_touch.dart';

void main() {
  const MethodChannel channel = MethodChannel('do_touch');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DoTouch.platformVersion, '42');
  });
}
