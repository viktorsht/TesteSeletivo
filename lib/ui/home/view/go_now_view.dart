import 'package:flutter/material.dart';
import 'package:go_fidelidade/domain/motel.dart';
import 'package:go_fidelidade/ui/carrossel/carrosel_widget.dart';
import 'package:go_fidelidade/ui/home/viewmodel/home_viewmodel.dart';
import 'package:go_fidelidade/ui/home/widgets/card_motel_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/filter_widget.dart';
import 'package:go_fidelidade/utils/result.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GoNowView extends StatefulWidget {
  final HomeViewModel viewModel;
  const GoNowView({super.key, required this.viewModel});

  @override
  State<GoNowView> createState() => _GoNowViewState();
}

class _GoNowViewState extends State<GoNowView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.red[600],
      onRefresh: () async {
        widget.viewModel.fetchMoteis();
      },
      child: ListenableBuilder(
        listenable: widget.viewModel.fetchMoteisCommand,
        builder: (context, child) {
          final state = widget.viewModel.fetchMoteisCommand;
          if (state.running) {
            return Skeletonizer(
              child: Column(
                children: [
                  CarroselWidget(),
                  FilterWidget(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CardMotelWidget(entity: Motel()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          if (state.error) {
            return const Center(child: Text("não há motéis para listar no momento!"));
          }

          if (state.result != null || state.running) {
            final result = state.result;
            if (result is Ok<List<Motel>>) {
              final moteis = result.value;
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: CarroselWidget(),
                  ),
                  SliverAppBar(
                    pinned: true, 
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      title: FilterWidget(),
                      background: Container(color: Colors.white),
                    ),
                  ), 
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final motel = moteis[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CardMotelWidget(entity: motel),
                        );
                      },
                      childCount: moteis.length,
                    ),
                  ),
                ],
              );
            }
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
