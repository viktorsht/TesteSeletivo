import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_fidelidade/ui/home/widgets/floating_map_button_widget.dart';

void main() {
  testWidgets('FloatingMapButtonWidget has map icon and text', (WidgetTester tester) async {
    // Cria um widget de teste com o onPressed vazio
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FloatingMapButtonWidget(
            onPressed: () {},
          ),
        ),
      ),
    );

    // Verifica se o widget FloatingMapButtonWidget está presente
    expect(find.byType(FloatingMapButtonWidget), findsOneWidget);

    // Verifica se o ícone de mapa está presente
    expect(find.byIcon(Icons.map), findsOneWidget);

    // Verifica se o texto "mapa" está presente
    expect(find.text('mapa'), findsOneWidget);
  });

  testWidgets('FloatingMapButtonWidget triggers onPressed when clicked', (WidgetTester tester) async {
    // Cria uma variável para verificar se o onPressed é chamado
    bool isPressed = false;

    // Cria o widget de teste
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FloatingMapButtonWidget(
            onPressed: () {
              isPressed = true;
            },
          ),
        ),
      ),
    );

    // Verifica se o widget está na tela
    expect(find.byType(FloatingMapButtonWidget), findsOneWidget);

    // Clica no botão
    await tester.tap(find.byType(FloatingMapButtonWidget));
    await tester.pump();

    // Verifica se o onPressed foi chamado
    expect(isPressed, true);
  });
}
