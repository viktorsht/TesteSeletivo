import 'package:flutter/material.dart';
import 'package:go_fidelidade/config/injector.dart';
import 'package:go_fidelidade/ui/home/viewmodel/home_viewmodel.dart';
import 'package:go_fidelidade/ui/home/viewmodel/page_controller_viewmodel.dart';
import 'package:go_fidelidade/ui/home/widgets/drawer_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/selection_page_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/floating_map_button_widget.dart';
import 'package:go_fidelidade/utils/app_bar_clipper.dart';

import 'go_now_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin{
  final viewModel = injector.get<HomeViewModel>();
  final pageControllerViewmodel  = PageControllerViewmodel();

  @override
  void initState() {
    super.initState();
    pageControllerViewmodel.initPageController(0);
    viewModel.fetchMoteis();
  }


  @override
  void dispose() {
    viewModel.dispose();
    pageControllerViewmodel.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: ClipPath(
          clipper: AppBarClipper(),
          child: AppBar(
            elevation: 0,
            toolbarHeight: 100,
            backgroundColor: Colors.red.shade600,
            title: SelectionPageWidget(pageControllerViewmodel: pageControllerViewmodel),
            iconTheme: IconThemeData(color: Colors.white), 
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: PageView(
        controller: pageControllerViewmodel.pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          GoNowView(viewModel: viewModel,),
          GoNowView(viewModel: viewModel,),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingMapButtonWidget(
        onPressed: () {
        },
      ),
    );
  }

  
}
