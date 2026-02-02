import 'package:flutter/material.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class NotificationCard extends StatelessWidget {
  final String? title;
  final String description;
  final String? date;
  const NotificationCard({
    super.key,
    this.title,
    required this.description,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => TransactionDetails()),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Color(0xFFFF2F3F4),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(Icons.notifications_active, color: AppColors.mainVioletColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null && title!.isNotEmpty)
                      Text(
                        title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions().responsiveFont(context,16),
                        ),
                      ),
                    SizedBox(height: AppDimensions.h10(context)),
                    Text(
                      description,
                      style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                      softWrap: true,
                    ),
                    SizedBox(height: AppDimensions.h10(context)),
                    if (date != null && date!.isNotEmpty)
                      Text(
                        date!,
                        style: TextStyle(color: AppColors.grisClair, fontSize: AppDimensions().responsiveFont(context,16)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}