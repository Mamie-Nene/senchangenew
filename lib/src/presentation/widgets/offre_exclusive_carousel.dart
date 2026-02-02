import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';


class OffreExclusiveCarousel extends StatefulWidget {
  @override
  _OffreExclusiveCarouselState createState() => _OffreExclusiveCarouselState();
}

class _OffreExclusiveCarouselState extends State<OffreExclusiveCarousel> {
  int _current = 0;

  List<String> imageUrls = [AppImages.CAROUSEL_IMAGES,AppImages.CAROUSEL_IMAGES1,AppImages.CAROUSEL_IMAGES2,];

  void removeCard(int index) {
    setState(() {
      imageUrls.removeAt(index);
      if (_current >= imageUrls.length) {
        _current = imageUrls.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index, realIdx) {
              return KeyedSubtree(
                key: ValueKey(imageUrls[index]),
                child: Container(
                  //width: MediaQuery.of(context).size.width * (imageUrls.length == 1 ? 1.0 : 0.9),
                  height: MediaQuery.of(context).size.height/6,//130
                  margin: const EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          imageUrls[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(204, 255, 255, 255),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.close, size: 14, color: Colors.black87,),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(), //empêche l’expansion par défaut
                            onPressed: () {removeCard(index);},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height/6,//130
            //  viewportFraction: imageUrls.length == 1 ? 1.0 : 0.9,
              viewportFraction: 1.0,
              autoPlay: imageUrls.length > 1,
              enableInfiniteScroll: false,
              autoPlayInterval: Duration(seconds: 3,), // Temps entre chaque slide
              autoPlayAnimationDuration: Duration(milliseconds: 600),
              padEnds: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        SizedBox(height:AppDimensions.h8(context)),
      ],
    );
  }
}