import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_fidelidade/ui/home/viewmodel/page_controller_viewmodel.dart';
import 'package:go_fidelidade/utils/routes_data/image_select_data.dart';

class ImageSelectionView extends StatefulWidget {
  final ImageSelectData data;

  const ImageSelectionView({super.key, required this.data});

  @override
  State<ImageSelectionView> createState() => _ImageSelectionViewState();
}

class _ImageSelectionViewState extends State<ImageSelectionView> {
  final pageControllerViewmodel  = PageControllerViewmodel();

  @override
  void initState() {
    super.initState();
    pageControllerViewmodel.initPageController(widget.data.index);
  }

  @override
  void dispose() {
    pageControllerViewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: pageControllerViewmodel,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  child: PageView.builder(
                    controller: pageControllerViewmodel.pageController,
                    itemCount: widget.data.images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.data.images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                    onPageChanged: (index) {
                      pageControllerViewmodel.setIndex(index);
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        widget.data.title.toString().toLowerCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios, size: 18,),
                            onPressed: () => pageControllerViewmodel.goToPrevious(),
                          ),
                          Text(
                            '${pageControllerViewmodel.currentIndex + 1}/${widget.data.images.length}',
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios, size: 18),
                            onPressed: () => pageControllerViewmodel.goToNext(widget.data.images.length),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 32.0,
                right: 16.0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => context.pop(),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
