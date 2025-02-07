import 'package:flutter/material.dart';

class PageControllerViewmodel extends ChangeNotifier{
  late PageController _pageController;

  PageController get pageController => _pageController;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  ValueNotifier<bool> isSelectedNow = ValueNotifier<bool>(true);


  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOut;

  void initPageController(int index) {
    _pageController = PageController(initialPage: index);
    setIndex(index);
  }

  void setIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }

  void goToPage(int index) {
    _pageController.animateToPage( index, duration: _duration, curve: _curve,);
  }

  void goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(duration: _duration, curve: _curve);
    }
  }

  void goToNext(int total) {
    if (_currentIndex < total - 1) {
      _pageController.nextPage(duration: _duration, curve: _curve);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}