
import 'package:flutter/material.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';


class AppAppBars extends StatelessWidget implements PreferredSizeWidget{
final String title;
final VoidCallback action;
  const AppAppBars({Key? key, required this.title, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text(title),
        leading: IconButton(
            onPressed: action,
            icon: Icon(Icons.arrow_back),
        )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}