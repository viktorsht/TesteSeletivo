import 'package:flutter/material.dart';

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0); // Inicia no topo esquerdo
    path.lineTo(size.width, 0); // Vai até o topo direito
    path.lineTo(size.width, size.height); // Desce até a parte inferior direita
    path.arcToPoint(Offset(size.width - 20, size.height - 20), radius: Radius.circular(20), clockwise: false); // Curva o canto inferior direito
    path.lineTo(20, size.height - 20); // Vai para o canto inferior esquerdo
    path.arcToPoint(Offset(0, size.height), radius: Radius.circular(20), clockwise: false); // Curva o canto inferior esquerdo
    path.close(); // Fecha o caminho
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}