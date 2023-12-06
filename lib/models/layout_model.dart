import 'package:flutter/material.dart';

import 'package:forsis/pages/slideshow_page.dart';

class LayoutModel with ChangeNotifier {
  Widget _currentPage = const SlideshowPage();

  Widget get currentPage => _currentPage;
  set currentPage(Widget valor) {
    _currentPage = valor;
    notifyListeners();
  }
}
