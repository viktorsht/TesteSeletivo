import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_fidelidade/domain/suite.dart';
import 'package:go_fidelidade/ui/categotias_itens/view/categorias_itens_view.dart';
import 'package:go_fidelidade/ui/home/view/home_view.dart';
import 'package:go_fidelidade/ui/image_grid/view/image_grid_view.dart';
import 'package:go_fidelidade/ui/image_grid/view/image_selection_view.dart';
import 'package:go_fidelidade/ui/splash/splash_view.dart';
import 'package:go_fidelidade/utils/routes_data/image_select_data.dart';
import 'package:go_fidelidade/utils/routes_data/images_data.dart';

class RoutesPath{
  static String root = '/'; // splash
  static String home = '/home';
  static String imageGrid = '/imageGrid';
  static String imageSelection = '/imageSelection';
  static String categorias = '/categorias';
}


class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[      
      GoRoute(
        path: RoutesPath.root,
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RoutesPath.home,
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: RoutesPath.imageGrid,
        name: 'imageGrid',
        builder: (context, state) {
          final data = state.extra as GalleryData;
          return ImageGridView(imageUrls: data.images, suite: data.title,);
        }
      ),
      GoRoute(
        path: RoutesPath.imageSelection,
        name: RoutesPath.imageSelection,
        builder: (context, state) {
          final data = state.extra as ImageSelectData;
          return ImageSelectionView(data: data);
        }
      ),
      GoRoute(
        path: RoutesPath.categorias,
        name: RoutesPath.categorias,
        builder: (context, state) {
          return CategoriasItensView(entity: state.extra as Suite);
        }
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(child: Text('Página não encontrada.')),
    ),
  );
}
