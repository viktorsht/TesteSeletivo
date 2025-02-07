import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_fidelidade/domain/periodo.dart';
import 'package:go_fidelidade/domain/suite.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/card_periodo_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/list_suite_carousel_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/card_suite_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/itens_categotia_widget.dart';
import 'package:mocktail/mocktail.dart';

class MockSuite extends Mock implements Suite {}

void main() {
  group('ListSuiteCarouselWidget', () {

    testWidgets('exibe os itens corretamente quando a lista não está vazia', (WidgetTester tester) async {
      // Arrange: criar uma lista de objetos Suite mockados
      final suiteMock = MockSuite();
      when(() => suiteMock.nome).thenReturn('Suite Teste');
      when(() => suiteMock.fotos).thenReturn([]);
      when(() => suiteMock.categoriaItens).thenReturn([]);
      when(() => suiteMock.periodos).thenReturn([Periodo(), Periodo(), Periodo()]);

      final suites = [suiteMock];

      // Act: construir o widget com a lista de suites
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListSuiteCarouselWidget(list: suites),
          ),
        ),
      );

      // Assert: verificar se o PageView exibe o número correto de itens
      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(CardSuiteWidget), findsOneWidget); // Verificar CardSuiteWidget
      expect(find.byType(ItensCategotiaWidget), findsOneWidget); // Verificar ItensCategotiaWidget
      expect(find.byType(CardPeriodoWidget), findsNWidgets(3)); // Verificar 3 CardPeriodoWidget
    });
  });
}
