import 'package:flutter/material.dart';
import '/src/presentation/widgets/app_auth_header.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class AuthPageShell extends StatelessWidget {
  const AuthPageShell({
    super.key,
    required this.isAppBarNeeded,
    required this.padding,
    required this.child,
    required this.isForSignUpPage,
    this.appBar,
    this.bgColor,
  });

  final Color? bgColor;
  final bool isAppBarNeeded;
  final bool isForSignUpPage;
  final AppBar? appBar;

  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: bgColor ?? AppColors.bgColor,
      appBar: isAppBarNeeded?AppBar(backgroundColor: AppColors.bgColor):null,
      body: SafeArea(
          top: false,
        child: Padding(
          padding:  EdgeInsets.only(top: padding),
          child: Column(
            //isForSignUpPage? mainAxisAlignment: MainAxisAlignment.center
            children: [
              const AppAuthHeader(title: '',subtitle: '',),

              SizedBox(height:AppDimensions.h20(context)),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border(
                      top: BorderSide(color: AppColors.orangeColor, width: 1),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),//login  padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20,), signup padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20,),
                    child: child,
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}