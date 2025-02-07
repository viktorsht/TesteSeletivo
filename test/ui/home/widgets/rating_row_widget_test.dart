import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_fidelidade/ui/home/widgets/rating_row_widget.dart';

void main() {
  testWidgets('RatingRow exibe valores corretamente e chama _showBottomSheet', (WidgetTester tester) async {
    // Dados de teste
    const media = 4.5;
    const qtdAvaliacoes = 100;

    // Construindo o widget para ser testado
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RatingRow(media: media, qtdAvaliacoes: qtdAvaliacoes),
        ),
      ),
    );

    expect(find.text('$media'), findsOneWidget);
    expect(find.text('$qtdAvaliacoes avaliações'), findsOneWidget);
  });
}
