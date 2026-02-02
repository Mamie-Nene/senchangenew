import 'package:flutter/material.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool isPushActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(backgroundColor: AppColors.bgColor, title: Text("Notifications")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Notification Push",
                      style: TextStyle(
                        fontSize: AppDimensions().responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(Icons.notifications, color: AppColors.orangeColor),
                    trailing: Switch(
                      value: isPushActive,
                      onChanged: (value) {
                        setState(() {
                          isPushActive = value;
                        });
                      },
                      activeColor: AppColors.orangeColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
