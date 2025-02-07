import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_fidelidade/config/routes.dart';
import 'package:go_fidelidade/domain/suite.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/card_periodo_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/card_suite_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/itens_categotia_widget.dart';
import 'package:go_fidelidade/utils/routes_data/images_data.dart';

class ListSuiteCarouselWidget extends StatefulWidget {
  final List<Suite> list;

  const ListSuiteCarouselWidget({super.key, required this.list});

  @override
  State<ListSuiteCarouselWidget> createState() => _ListSuiteCarouselStateWidget();
}

class _ListSuiteCarouselStateWidget extends State<ListSuiteCarouselWidget> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      child: Column(
        children: [
          SizedBox(
            height: 700,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.isEmpty ? 1 : widget.list.length,
              itemBuilder: (context, index) {
                var suite = Suite();
                if (widget.list.isNotEmpty) {
                  suite = widget.list[index];
                }
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final data = GalleryData(images: suite.fotos ?? [], title: suite.nome ?? '');
                        (context).push(RoutesPath.imageGrid, extra: data);
                      },
                      child: CardSuiteWidget(suite: suite),
                    ),
                    GestureDetector(
                      onTap: () => (context).push(RoutesPath.categorias, extra: suite),
                      child: ItensCategotiaWidget(categoriaItens: suite.categoriaItens ?? []),
                    ),
                    CardPeriodoWidget(entity: suite.periodos?[0]),
                    CardPeriodoWidget(entity: suite.periodos?[1]),
                    CardPeriodoWidget(entity: suite.periodos?[2]),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}