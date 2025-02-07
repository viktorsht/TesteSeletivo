import 'package:flutter/material.dart';
import 'package:go_fidelidade/domain/suite.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardSuiteWidget extends StatelessWidget {
  final Suite? suite; // Agora é possível passar null, representando a ausência de uma suíte
  const CardSuiteWidget({super.key, this.suite}); // Permitir valor nulo
  
  Widget skeletonizerImage(){
    return Skeletonizer(
      child: Container(height: 200, width: double.infinity, color: Colors.grey[300]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Caso a suíte seja nula, retornar um widget vazio
    if (suite == null) {
      return SizedBox.shrink(); // Retorna um widget vazio, não exibindo nada
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 350,
        height: 280, 
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: suite!.fotos?.isEmpty ?? true 
                ? skeletonizerImage()
                : Image.network(
                    suite!.fotos?[0] ?? '',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return skeletonizerImage();
                      }
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return skeletonizerImage();
                    },
                  ),
            ),
            SizedBox(height: 5),
            Flexible(
              child: Text(
                suite!.nome ?? '',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 5),
            if(suite!.exibirQtdDisponiveis == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/sirene.png',
                    width: 18,
                    height: 18,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'só mais ${suite!.qtd} pelo app',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
