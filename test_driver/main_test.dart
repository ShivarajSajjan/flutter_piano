// This is a basic Flutter Driver test for the application. A Flutter Driver
// test is an end-to-end test that "drives" your application from another
// process or even from another computer. If you are familiar with
// Selenium/WebDriver for web, Espresso for Android or UI Automation for iOS,
// this is simply Flutter's version of that.

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:screenshots/config.dart';
import 'package:screenshots/capture_screen.dart';

void main() {
  group('end-to-end test', () {
    FlutterDriver driver;
    final Map config = Config().config;

    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();

    });

    tearDownAll(() async {
      if (driver != null) driver.close();
    });

    test('tap on the floating action button; verify counter', () async {
      // Finds the floating action button (fab) to tap on
      SerializableFinder fab = find.byTooltip('Increment');

      // Wait for the floating action button to appear
      await driver.waitFor(fab);

      // take screenshot before number is incremented
      await screenshot(driver, config, '0');

      // Tap on the fab
      await driver.tap(fab);

      // Wait for text to change to the desired value
      await driver.waitFor(find.text('1'));

      // take screenshot after number is incremented
      await screenshot(driver, config, '1');

      // increase timeout from 30 seconds for testing
      // on slow running emulators in cloud
    }, timeout: Timeout(Duration(seconds: 120)));
  });
}
