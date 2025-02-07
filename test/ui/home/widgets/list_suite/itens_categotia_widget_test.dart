import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_fidelidade/domain/categoria_item.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/itens_categotia_widget.dart';

void main() {
  group('ItensCategotiaWidget Tests', () {

    testWidgets('Should render empty space if categoriaItens is empty', (WidgetTester tester) async {
      // Lista vazia
      final categoriaItens = <CategoriaItem>[];

      // Carregar o widget com lista vazia
      await tester.pumpWidget(
        MaterialApp(
          home: ItensCategotiaWidget(categoriaItens: categoriaItens),
        ),
      );

      // Verificar que não há imagens sendo exibidas
      expect(find.byType(Image), findsNothing);

      // Verificar se o botão "ver todos" ainda está presente
      expect(find.text('ver'), findsOneWidget);
      expect(find.text('todos'), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });

  });
}
