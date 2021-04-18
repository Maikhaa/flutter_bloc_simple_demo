import 'package:flutter/material.dart';
import 'package:flutter_bloc_simple_demo/search_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_simple_demo/main.dart';

void main() {
  testWidgets('Finds SearchBar', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));
    var weatherInfo = find.byType(SearchBar);
    expect(weatherInfo, findsOneWidget);
  });
}
