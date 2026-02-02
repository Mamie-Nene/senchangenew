import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '/src/data/local/onboarding_local_data.dart';
import '/src/methods/check_status_methods.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    CheckStatusMethods.completeIntro(context);
 }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: IntroductionScreen(
        key: _introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        freeze: false,
        scrollPhysics: const BouncingScrollPhysics(),
        /* globalHeader: Align(
           alignment: Alignment.topRight,
           child: SafeArea(
             child: Padding(
               padding: const EdgeInsets.only(top: 16, right: 16),
               child: _buildImage('flutter.png', 100),
             ),
           ),
         ),
         globalFooter: SizedBox(
           width: double.infinity,
           height: 60,
           child: ElevatedButton(
             child: const Text(
               'Let\'s go right away!',
               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
             ),
             onPressed: () => _onIntroEnd(context),
           ),
         ),*/
        pages:List.generate(
          OnboardingLocalData().onboardingData.length,
              (index) => _buildPageViewModel(
                OnboardingLocalData().onboardingData[index]["title"]!,
                OnboardingLocalData().onboardingData[index]["body"]!,
                OnboardingLocalData().onboardingData[index]["image"]!,
            context,
          ),
        ),
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,

        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip:Text(
          'Passer',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textGrisColor,
            fontSize: AppDimensions().responsiveFont(context,16),
          ),
        ),
        next:  CircleAvatar(
          backgroundColor: AppColors.orangeColor,
          foregroundColor: AppColors.textGrisColor,
          child: const Icon(Icons.arrow_forward),
        ),
        done: Container(
          decoration: BoxDecoration(
            color: AppColors.orangeColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Démarrer',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppDimensions().responsiveFont(context,16),
                color: AppColors.textGrisColor,
              ),
            ),
          ),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),

        dotsDecorator:  DotsDecorator(
          size: const Size(10.0, 10.0),
          color: AppColors.gris,
          activeColor: AppColors.orangeColor,
          activeSize: const Size(22.0, 10.0),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  PageViewModel _buildPageViewModel(String title, String body, String imageAsset,BuildContext context ) {

    TextStyle bodyStyle = TextStyle(fontSize: AppDimensions().responsiveFont(context,19.0));

    PageDecoration pageDecoration = PageDecoration(
      pageMargin: const EdgeInsets.only(top: 100),
      titleTextStyle: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return  PageViewModel(
      title: title,
      body: body,
      image: _buildImage(imageAsset),
      decoration: pageDecoration,
    );
  }


}
