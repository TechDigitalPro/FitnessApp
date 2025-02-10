

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';

import '../../views/auth/login_view.dart';
import '../base_view_model.dart';

class IntroViewModel extends BaseViewModel{

  int currentIndex = 0;
  PageController pageController = PageController();

  initialize(BuildContext context) async {

  }

  onClickPrev() {
    if (currentIndex > 0) {
      currentIndex = currentIndex - 1;
      pageController.animateToPage(currentIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      notifyListeners();
    }
  }

  onClickNext(BuildContext context) {
    if (currentIndex < 2) {
      currentIndex = currentIndex + 1;
      pageController.animateToPage(currentIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      notifyListeners();
    } else {
      onClickSkip(context);
    }
  }

  onClickSkip(BuildContext context) {
    sharedService.saveIsFirst(false);
    LoginView().launch(context, isNewTask: true);
  }

  void setCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }
}