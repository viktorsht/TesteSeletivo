import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_fidelidade/utils/app_bar_clipper.dart';


void main() {
  test('AppBarClipper deve gerar o Path corretamente', () {
    // Definir um tamanho de tela para testar
    final size = Size(400, 200);
    
    // Criar uma instância do AppBarClipper
    final clipper = AppBarClipper();
    
    // Gerar o Path
    final path = clipper.getClip(size);
    
    // Verificar se o Path contém os pontos esperados
    // Aqui, verificamos se o Path contém as linhas corretas
    final points = path.computeMetrics().first.getTangentForOffset(0.0)?.position;
    expect(points, isNotNull);

    // Testa se o Path é fechado corretamente
    expect(path.contains(Offset(0, 0)), isTrue); // Verifica se começa no ponto (0, 0)
    expect(path.contains(Offset(400, 0)), isTrue); // Verifica se vai até (400, 0)
    expect(path.contains(Offset(400, 200)), isTrue); // Verifica se vai até (400, 200)
    expect(path.contains(Offset(0, 200)), isTrue); // Verifica se vai até (0, 200)
    
    // Verifica as curvas nos cantos
    final arcStart1 = path.contains(Offset(380, 180)); // Verifica a curva do canto inferior direito
    final arcStart2 = path.contains(Offset(20, 180)); // Verifica a curva do canto inferior esquerdo
    expect(arcStart1, isTrue);
    expect(arcStart2, isTrue);
  });
}
