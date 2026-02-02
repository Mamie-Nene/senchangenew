import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/domain/notification_model.dart';
import '/src/services/notification_service.dart';
import '/src/services/notification_storage_service.dart';

import '/src/presentation/widgets/app_app_bars.dart';
import '/src/presentation/widgets/notification_card.dart';

import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';



class NotificationsPageV2 extends StatefulWidget {
  const NotificationsPageV2({super.key});

  @override
  State<NotificationsPageV2> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPageV2> {
  NotificationModel? notificationModel;
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    getNotificationsInStorage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notificationModel ??= Provider.of<NotificationModel>(
      context,
      listen: false,
    );
  }

  getNotificationsInStorage() async {
    List<Map<String, dynamic>> notifs =
    await NotificationStorageService.getNotifications();

    print("-----------get notifications in local storage---------");
    print(notifs.toString());

    setState(() {
      notifications = notifs;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final notifications = context.watch<NotificationModel>().notifications;

    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppAppBars(
        title:'Notifications',
        action: () async {
          Navigator.pop(context); // le nettoyage se fait dans dispose()
          await NotificationStorageService.clearNotifications();
          notificationModel!.clear();
          NotificationService.resetNotificationId();

          Navigator.of(context).pushReplacementNamed(AppRoutesName.accueilPage);
        }
      ),

      body:
      notifications.isEmpty
          ? const Center(child: Text("Aucune notification reçue"))
          :
      ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final message = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20,),
            child: NotificationCard(
              description: message['message'],
              // date: UtilsService.timeAgo(message["dateNotif"]),
            ),
          );
        },
      ),
    );
  }
}