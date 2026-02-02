import 'package:flutter/cupertino.dart';


class AppDimensions{
 // i was used static precomputed dimensions
 //Uses real-time screen size from MediaQuery
/* Use context-based dimensions instead of static precomputed ones or initialize before calculating dimensions
  //Size in logical pixels


 //to access the height page property and width page property
 static var pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;

 //Size in physical pixels
 static var physicalScreenSize = WidgetsBinding.instance.window.physicalSize;
 static var physicalWidth = physicalScreenSize.width;
 static var physicalHeight = physicalScreenSize.height;

 //Size in logical pixels
 static var logicalScreenSize = WidgetsBinding.instance.window.physicalSize / pixelRatio;
 static var logicalWidth = logicalScreenSize.width;
 static var logicalHeight = logicalScreenSize.height;

 //for about page
 static double imageContainer = logicalHeight/2.5;

 static double mainPageFirstContainerChild1 = logicalHeight/3.65;
 static double mainPageFirstContainerChild2 = logicalHeight/6.7 ;

 */
// ---------------------- Screen Dimensions ----------------------
 static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
 static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

 // ---------------------- Padding & Margin ----------------------
 static const double paddingSmall = 8.0;
 static const double paddingMedium = 16.0;
 static const double paddingLarge = 24.0;
 static const double paddingXLarge = 32.0;

 // ---------------------- Border Radius ----------------------
 static const double borderRadiusSmall = 4.0;
 static const double borderRadiusMedium = 8.0;
 static const double borderRadiusLarge = 12.0;
 static const double borderRadiusXLarge = 16.0;

 // ---------------------- Icon Sizes ----------------------
 static const double iconSizeSmall = 16.0;
 static const double iconSizeMedium = 24.0;
 static const double iconSizeLarge = 32.0;

 // ---------------------- Button Dimensions ----------------------
 static const double buttonHeight = 48.0;
 static const double buttonRadius = 8.0;

 // ---------------------- Dynamic Heights ----------------------
 static double height(BuildContext context, double ratio) =>
     screenHeight(context) / ratio;

 static double width(BuildContext context, double ratio) =>
     screenWidth(context) / ratio;

 //height
 double sizeHeightFor8 = 100;
 double sizeHeightFor15 = 55;
 double sizeHeightFor20 = 41;
 double sizeHeightFor30 = 27.4;
 double sizeHeightFor35 = 24;
 double sizeHeightFor40 = 20.9;
 double sizeHeightFor42 = 20;
 double sizeHeightFor50 = 16.5;
 double sizeHeightFor60 = 13.7;
 double sizeHeightFor90 = 9.15;
 double sizeHeightFor100 = 8.3;
 double sizeHeightFor120 = 6.9;//6.6
 double sizeHeightFor150 = 5.55;
 double sizeHeightFor200 = 4.15;
 double sizeHeightFor220 = 3.8;
 //30=27.4; so 35--> 24.5
 //40 = 20.9
 //width
 double sizeWidthFor90 = 4.2;
 double sizeWidthFor100 = 3.9;
 double sizeWidthFor120 = 3.25;
 double sizeWidthFor223 = 1.5;
 // double sizeWidthFor400 = MediaQuery.of(context).size.width+9;

 // height > 100

 static double h500(BuildContext context) =>  height(context,1.6581);
 static double h490(BuildContext context) =>  height(context,1.6920);
 static double h400(BuildContext context) =>  height(context,2.0727);
 static double h350(BuildContext context) =>  height(context,2.3688);
 static double h300(BuildContext context) =>  height(context,2.7636);
 static double h250(BuildContext context) =>  height(context,3.3163);
 static double h220(BuildContext context) =>  height(context,3.7685);
 static double h205(BuildContext context) =>  height(context,4.0443);
 static double h180(BuildContext context) =>  height(context,4.6060);
 static double h150(BuildContext context) =>  height(context,5.5272);

 static double h120(BuildContext context) =>  height(context,6.0900);
 static double h115(BuildContext context) =>  height(context,7.2094);
 static double h114et5(BuildContext context) =>  height(context,7.2409);
 static double h114(BuildContext context) =>  height(context,7.2727);
 static double h113(BuildContext context) =>  height(context,7.3370);
 static double h112(BuildContext context) =>  height(context,7.4025);
 static double h111(BuildContext context) =>  height(context,7.4692);

 // width >100

 static double w374(BuildContext context) => width(context, 1.0500);
 static double w350(BuildContext context) => width(context, 1.1220);
 static double w228(BuildContext context) => width(context, 1.7222);
 static double w223(BuildContext context) => width(context, 1.7611);
 static double w107(BuildContext context) => width(context, 3.6703);
 static double w186(BuildContext context) => width(context, 2.1114);
 static double w185(BuildContext context) => width(context, 2.1228);
 static double w183(BuildContext context) => width(context, 2.1460);
 static double w137(BuildContext context) => width(context, 2.8666);
 static double w170(BuildContext context) => width(context, 2.3101);
 static double w165(BuildContext context) => width(context, 2.3801);
 static double w160(BuildContext context) => width(context, 2.4545);
 static double w150(BuildContext context) => width(context, 2.6181);
 static double w130(BuildContext context) => width(context, 3.0209);
 static double w100(BuildContext context) => width(context, 3.9272);


//sizebox height <100
//830
 static double h100(BuildContext context) => height(context, 8.2909);
 static double h90(BuildContext context) => height(context, 9.2121);
 static double h85(BuildContext context) => height(context, 9.7539);
 static double h80(BuildContext context) => height(context, 10.3636);
 static double h66(BuildContext context) => height(context, 12.5619);
 static double h60(BuildContext context) => height(context, 13.8181);
 static double h55(BuildContext context) => height(context, 15.0743);
 static double h50(BuildContext context) => height(context, 16.5818);
 static double h45(BuildContext context) => height(context, 18.4242);
 static double h40(BuildContext context) => height(context, 20.7272);
 static double h35(BuildContext context) => height(context, 23.6883);
 static double h30(BuildContext context) => height(context, 27.6363);
 static double h25(BuildContext context) => height(context, 33.1636);
 static double h24(BuildContext context) => height(context, 37.6859);
 static double h20(BuildContext context) => height(context, 41.4545);
 static double h15(BuildContext context) => height(context, 55.2727);
 static double h10(BuildContext context) => height(context, 82.9090);
 static double h5(BuildContext context) => height(context, 165.8181);


 static double h48 (BuildContext context) => height(context, 17.2727);


 static double h39 (BuildContext context) => height(context, 21.2567);

 static double h22 (BuildContext context) => height(context, 37.6859);
 static double h18 (BuildContext context) => height(context, 46.0606);
 static double h17 (BuildContext context) => height(context, 47.7700);

 static double h13 (BuildContext context) => height(context, 63.7762);
 static double h12 (BuildContext context) => height(context, 69.0909);


 static double h9 (BuildContext context) => height(context, 92.1212);
 static double h8 (BuildContext context) => height(context, 103.6363);
 static double h7 (BuildContext context) => height(context, 118.4415);




 //sizebox  width <100

//393 width
 static double w90(BuildContext context) => width(context,4.3636);
 static double w83(BuildContext context) => width(context,4.7316);
 static double w75(BuildContext context) => width(context,5.2362);
 static double w65(BuildContext context) => width(context,6.0461);
 static double w60(BuildContext context) => width(context, 6.5452);
 static double w55(BuildContext context) => width(context, 7.1404);
 static double w50(BuildContext context) => width(context, 7.8545);
 static double w45(BuildContext context) => width(context, 8.7272);
 static double w40(BuildContext context) => width(context, 9.8181);
 static double w30(BuildContext context) => width(context, 13.0909);
 static double w20(BuildContext context) => width(context, 19.636);
 static double w18(BuildContext context) => width(context,21.8181);
 static double w17(BuildContext context) => width(context,23.1016);
 static double w15(BuildContext context) => width(context,26.1818);
 static double w10(BuildContext context) => width(context, 39.2722);
 static double w9(BuildContext context) => width(context,43.6363);
 static double w7(BuildContext context) => width(context,56.1038);
 static double w5(BuildContext context) => width(context,78.5454);

 //for ipad correction and tablette

 double responsiveFont(BuildContext context, double mobileSize) {
  final width = MediaQuery.of(context).size.width;
  if (width > 600) {
   // iPad, tablette
   return mobileSize * 1.35; // +35%
  }
  return mobileSize;
 }

 bool isTablet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final shortestSide = size.shortestSide;
  return shortestSide >= 600; // tablets + iPads
 }

}