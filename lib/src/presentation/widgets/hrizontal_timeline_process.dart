import 'package:flutter/material.dart';

class HorizontalProcessTimeline extends StatelessWidget {
  final int currentStep;
  final List<Map<String, dynamic>> steps;
  // = [
  //   {"title": "Initialisé", "icon": Icons.check, "color": Colors.blue},
  //   {"title": "En cours", "icon": Icons.map, "color": Colors.orange},
  //   // cette 3ieme etape peut etre accepté ou refusé
  //   {"title": "Accepté", "icon": Icons.attach_money, "color": Colors.purple},
  // ];

  const HorizontalProcessTimeline({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 120,
      child: Stack(
        children: [
          // Ligne de fond qui relie toutes les étapes
          Positioned(
            top: 15, // Ajustez selon la position de vos cercles
            left: 0,
            right: 0,
            child: Row(
              children: List.generate(steps.length - 1, (index) {
                bool isCompleted = index < currentStep;
                // Color connectorColor =
                //     isCompleted ? steps[index]["color"] : Colors.grey.shade300;
                Color connectorColor =
                    isCompleted
                        ? const Color.fromARGB(255, 97, 97, 97)
                        : Colors.grey.shade300;

                return Expanded(
                  child: Container(
                    height: 3,
                    color: connectorColor,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                );
              }),
            ),
          ),

          // Étapes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(steps.length, (index) {
              bool isActive = index <= currentStep;
              Color stepColor =
                  isActive ? steps[index]["color"] : Colors.grey.shade300;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Point de l'étape
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: stepColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Icon(
                      steps[index]["icon"],
                      color: Colors.white,
                      size: 16,
                    ),
                  ),

                  // Texte sous l'étape
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    constraints: const BoxConstraints(minWidth: 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          steps[index]["title"],
                          style: TextStyle(
                            color: isActive ? Colors.black : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // SizedBox(height: AppDimensions.h4(context)),
                        // Text(
                        //   "Step ${index + 1}",
                        //   style: TextStyle(
                        //     color: isActive ? Colors.black54 : Colors.grey,
                        //     fontSize: AppDimensions().responsiveFont(context,12,
                        //   ),
                        // ),
                        // if (isActive && index == currentStep)
                        //   const SizedBox(height: AppDimensions.h8),
                        // if (isActive && index == currentStep)
                        //   Container(
                        //     height: 4,
                        //     width: 40,
                        //     decoration: BoxDecoration(
                        //       color: steps[index]["color"],
                        //       borderRadius: BorderRadius.circular(2),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
