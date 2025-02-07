import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_fidelidade/domain/carrosel_item.dart';

class CarroselWidget extends StatefulWidget {

  const CarroselWidget({super.key,});

  @override
  State<CarroselWidget> createState() => _CarroselWidgetState();
}

List<CarroselItem> carroselList = [
  CarroselItem(
    name: "Motel Lux",
    image: "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg",
    location: "Dubai Marina, Dubai",
    discount: "20% de desconto",
    startingFrom: "a partir de R\$56,67",
  ),
  CarroselItem(
    name: "Beach Paradise",
    image: "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9828_2.jpg",
    location: "Palm Jumeirah, Dubai",
    discount: "15% de desconto",
    startingFrom: "a partir de R\$56,67",
  ),
  CarroselItem(
    name: "Downtown Motel",
    image: "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9829_1.jpg",
    location: "Downtown Dubai, Dubai",
    discount: "30% de desconto",
    startingFrom: "a partir de R\$56,67",
  ),
  CarroselItem(
    name: "Skyline Suites",
    image: "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9831_2.jpg",
    location: "Business Bay, Dubai",
    discount: "10% de desconto",
    startingFrom: "a partir de R\$56,67",
  ),
];


class _CarroselWidgetState extends State<CarroselWidget> {
  final _pageController = PageController();
  Timer? _timer;
   int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: carroselList.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Image.network(
                      carroselList[index].image,
                      width: widthScreen / 2.3,
                      height: widthScreen / 2.3,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SizedBox(
                        height: widthScreen / 2.2,
                        width: widthScreen / 2.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 SvgPicture.asset(
                                  'assets/fire.svg',
                                  width: 25,
                                  height: 25,
                                   colorFilter: const ColorFilter.mode(
                                    Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 2,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(carroselList[index].name, 
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
                                    ),
                                    Text(carroselList[index].location,
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(carroselList[index].discount,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black
                              ),                          
                            ),
                            Text(carroselList[index].startingFrom),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 37, 170, 77),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5), // Bordas leves
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Reservar",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                                ],
                              ),
                            )
                        
                        
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              carroselList.length,
              (index) => Container(
                margin: const EdgeInsets.all(4),
                width: _currentPage == index ? 8 : 6,
                height: _currentPage == index ? 8 : 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.grey[800] : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}