import 'package:flutter/material.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import 'package:timelines_plus/timelines_plus.dart';

class ProcessTimeline extends StatefulWidget {
  const ProcessTimeline({super.key});

  @override
  State<ProcessTimeline> createState() => _ProcessTimelineState();
}

class _ProcessTimelineState extends State<ProcessTimeline> {
  int currentStep = 0;

  final List<Map<String, dynamic>> steps = [
    {"title": "Prospect", "icon": Icons.handshake},
    {"title": "Tour", "icon": Icons.map},
    {"title": "Offer", "icon": Icons.attach_money},
    {"title": "Contract", "icon": Icons.description},
    {"title": "Settled", "icon": Icons.home},
  ];

  void _nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() => currentStep++);
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Process Timeline"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(height: AppDimensions.h20(context)),
          SizedBox(
            height: 100,
            child: Timeline(
              theme: TimelineThemeData(nodePosition: 0.15),
              children: List.generate(steps.length, (index) {
                bool isActive = index <= currentStep;
                bool isCompleted = index < currentStep;

                return TimelineTile(
                  node: TimelineNode(
                    indicator: DotIndicator(
                      size: 30,
                      color: isActive ? Colors.green : Colors.grey.shade300,
                      child: Icon(
                        steps[index]["icon"],
                        color: isActive ? Colors.white : Colors.grey,
                        size: 16,
                      ),
                    ),
                    startConnector:
                        index == 0
                            ? null
                            : SolidLineConnector(
                              color:
                                  isCompleted
                                      ? Colors.green
                                      : Colors.grey.shade300,
                              thickness: 2,
                            ),
                    endConnector:
                        index == steps.length - 1
                            ? null
                            : SolidLineConnector(
                              color:
                                  isCompleted
                                      ? Colors.green
                                      : Colors.grey.shade300,
                              thickness: 2,
                            ),
                  ),
                  contents: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[index]["title"],
                          style: TextStyle(
                            color: isActive ? Colors.green : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions().responsiveFont(context,16),
                          ),
                        ),
                        if (isActive) SizedBox(height:4),
                        if (isActive)
                          Text(
                            "Step ${index + 1}",
                            style:  TextStyle(
                              color: Colors.grey,
                              fontSize: AppDimensions().responsiveFont(context,12),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: _previousStep,
                  backgroundColor: currentStep > 0 ? Colors.blue : Colors.grey,
                  heroTag: 'back',
                  child: const Icon(Icons.arrow_back),
                ),
                FloatingActionButton(
                  onPressed: _nextStep,
                  backgroundColor:
                      currentStep < steps.length - 1
                          ? Colors.green
                          : Colors.grey,
                  heroTag: 'next',
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimensions.h20(context)),
        ],
      ),
    );
  }
}
