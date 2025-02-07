import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_fidelidade/ui/image_grid/view/image_grid_view.dart';

void main() {
  group('ImageGridView Tests', () {

    testWidgets('Should display "Esta suíte não possui imagens." when imageUrls is empty', (WidgetTester tester) async {
      // Lista vazia de imagens
      final imageUrls = <String>[];
      final suite = 'Suite Sem Imagens';

      // Carregar o widget com a lista vazia de imagens
      await tester.pumpWidget(
        MaterialApp(
          home: ImageGridView(imageUrls: imageUrls, suite: suite),
        ),
      );

      // Verificar se o texto "Esta suíte não possui imagens." é exibido
      expect(find.text('Esta suíte não possui imagens.'), findsOneWidget);
    });
  });
}
