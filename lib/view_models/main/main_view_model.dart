import 'package:flutter/material.dart';
import 'package:nxtlvl_app/views/main/home_view.dart';
import 'package:nxtlvl_app/views/main/profile_view.dart';
import 'package:nxtlvl_app/views/main/trainer_view.dart';
import 'package:nxtlvl_app/views/main/workout_view.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../model/common/user_model.dart';
import '../../utils/image_utils.dart';
import '../../utils/string_utils.dart';
import '../base_view_model.dart';

class MainViewModel extends BaseViewModel{
  UserModel? user;
  int selectedIndex = 0;
  TabController? mTabController;
  List<Widget> navWidgets = [];
  List<String> navTitles = [];
  List<String> navIcons = [];
  String commonPageName = '';

  initialize(BuildContext context, int? index, TabController? tabController) async{
    mTabController = tabController;
    navWidgets = [
      HomeView(),
      TrainerView(),
      WorkoutView(),
      ProfileView(),
    ];
    navTitles = [
      StringUtils.txtHome,
      StringUtils.txtTrainer,
      StringUtils.txtWorkout,
      StringUtils.txtProfile,
    ];
    navIcons = [
      ImageUtils.imgIcBottomHome,
      ImageUtils.imgIcBottomTrainer,
      ImageUtils.imgIcBottomWorkout,
      ImageUtils.imgIcBottomProfile,
    ];

    if (index != null) {
      setSelectedIndex(index);
    } else {
      setSelectedIndex(0);
    }
    user = await sharedService.getUser();

    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });

    initBottomBar();
    notifyListeners();
  }

  initBottomBar(){
    
  }

  onNotificationClicked(BuildContext context) {
    
  }

  setSelectedIndex(int index) async{
    selectedIndex = index;
    await Future.delayed(const Duration(milliseconds: 300));
    mTabController?.animateTo(selectedIndex, curve: Curves.easeIn);
    notifyListeners();
  }
}