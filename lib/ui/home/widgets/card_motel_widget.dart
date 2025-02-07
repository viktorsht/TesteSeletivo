import 'package:flutter/material.dart';
import 'package:go_fidelidade/domain/motel.dart';
import 'package:go_fidelidade/ui/home/widgets/list_suite/list_suite_carousel_widget.dart';
import 'package:go_fidelidade/ui/home/widgets/rating_row_widget.dart';

class CardMotelWidget extends StatefulWidget {
  final Motel entity;
  const CardMotelWidget({super.key, required this.entity});

  @override
  State<CardMotelWidget> createState() => _CardMotelWidgetState();
}

class _CardMotelWidgetState extends State<CardMotelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(widget.entity.logo != null && widget.entity.logo!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0), // Move o CircleAvatar para baixo
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(widget.entity.logo ?? ''),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.entity.fantasia.toString().toLowerCase(),
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        widget.entity.bairro.toString().toLowerCase(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      RatingRow(
                        media: widget.entity.media ?? 0.0,
                        qtdAvaliacoes: widget.entity.qtdAvaliacoes ?? 0,
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite, color: Colors.grey,),
              ),
            ],
          ),
          ListSuiteCarouselWidget(list: widget.entity.suites ?? [],),
        ],
      ),
    );
  }
}