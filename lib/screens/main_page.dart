import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:FlutterGalleryApp/data_provider.dart';
import 'package:FlutterGalleryApp/screens/profile/profile_container.dart';
import 'package:FlutterGalleryApp/states/profile/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  final currentTab = 2.obs;
  final List<Widget> pages = [Feed(), Container(), ProfileContainer()];
  final menuItems = [
    BottomNavyBarItem(
      asset: AppIcons.home,
      title: Text('Feed'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    ),
    BottomNavyBarItem(
      asset: Icons.search,
      title: Text('Search'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    ),
    BottomNavyBarItem(
      asset: Icons.person_rounded,
      title: Text('User'),
      activeColor: AppColors.dodgerBlue,
      inactiveColor: AppColors.manatee,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(() => BottomNavyBar(
              itemCornerRadius: 8,
              curve: Curves.ease,
              currentTab: currentTab.value,
              onItemSelected: (int index) async {
                if (index == 2) {
                  if (DataProvider.token == null || DataProvider.token == null) {
                    try {
                      final result = await DataProvider.getAuthToken();
                      DataProvider.token = result;
                      currentTab.value = index;
                      Get.find<ProfileController>().fetchProfile();
                    } catch (e) {
                      print(e);
                    }
                  } else {
                    currentTab.value = index;
                    Get.find<ProfileController>().fetchProfile();
                  }
                } else {
                  currentTab.value = index;
                }
              },
              items: menuItems,
            )),
        body: Obx(
          () => pages[currentTab.value],
        ));
  }
}

class BottomNavyBar extends StatelessWidget {
  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;
  final MainAxisAlignment mainAxisAlignment;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentTab;
  final Duration animationDuration;
  final double itemCornerRadius;
  final Curve curve;

  const BottomNavyBar({
    Key key,
    this.backgroundColor = Colors.white,
    this.showElevation = true,
    this.containerHeight = 56,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.items,
    this.onItemSelected,
    this.currentTab,
    this.animationDuration = const Duration(milliseconds: 270),
    this.itemCornerRadius = 24,
    this.curve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
            )
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  animationDuration: animationDuration,
                  backgroundColor: backgroundColor,
                  item: item,
                  itemCornerRadius: itemCornerRadius,
                  curve: curve,
                  isSelected: currentTab == index,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;

  BottomNavyBarItem({this.asset, this.title, this.activeColor, this.inactiveColor, this.textAlign}) {
    assert(asset != null, 'Assert is null');
    assert(title != null, 'Title is null');
  }
}

class _ItemWidget extends StatelessWidget {
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double itemCornerRadius;

  _ItemWidget({
    Key key,
    @required this.isSelected,
    @required this.item,
    @required this.backgroundColor,
    @required this.animationDuration,
    this.curve = Curves.linear,
    @required this.itemCornerRadius,
  }) : super(key: key) {
    assert(animationDuration != null, 'animationDuration is null');
    assert(isSelected != null, 'isSelected is null');
    assert(item != null, 'item is null');
    assert(curve != null, 'curve is null');
    assert(itemCornerRadius != null, 'itemCornerRadius is null');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: isSelected ? 150 : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      height: double.infinity,
      curve: curve,
      decoration: BoxDecoration(
          color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius)),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 4,
          ),
          Icon(
            item.asset,
            size: 20,
            color: isSelected ? item.activeColor : item.inactiveColor,
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: DefaultTextStyle.merge(
                  child: item.title,
                  textAlign: item.textAlign,
                  maxLines: 1,
                  style: TextStyle(color: isSelected ? item.activeColor : item.inactiveColor, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
