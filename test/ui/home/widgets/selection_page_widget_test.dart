import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_fidelidade/ui/home/viewmodel/page_controller_viewmodel.dart';
import 'package:go_fidelidade/ui/home/widgets/selection_page_widget.dart';

void main() {
  group('SelectionPageWidget Tests', () {
    late PageControllerViewmodel pageControllerViewmodel;

    setUp(() {
      // Criar o PageControllerViewmodel antes de cada teste
      pageControllerViewmodel = PageControllerViewmodel();
      pageControllerViewmodel.initPageController(0);
    });

    testWidgets('Should display the "ir agora" and "ir outro dia" items', (WidgetTester tester) async {
      // Carregar o widget no teste
      await tester.pumpWidget(
        MaterialApp(
          home: SelectionPageWidget(pageControllerViewmodel: pageControllerViewmodel),
        ),
      );

      // Verificar se os textos "ir agora" e "ir outro dia" estão visíveis
      expect(find.text('ir agora'), findsOneWidget);
      expect(find.text('ir outro dia'), findsOneWidget);
    });

    testWidgets('Should display icon for "ir agora" and "ir outro dia"', (WidgetTester tester) async {
      // Carregar o widget no teste
      await tester.pumpWidget(
        MaterialApp(
          home: SelectionPageWidget(pageControllerViewmodel: pageControllerViewmodel),
        ),
      );

      // Verificar se os ícones estão presentes
      expect(find.byIcon(Icons.flash_on), findsOneWidget);
      expect(find.byIcon(Icons.check_box_outlined), findsOneWidget);
    });
  });
}
