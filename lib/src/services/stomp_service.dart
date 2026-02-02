import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../utils/api/api_url.dart';
import '/src/methods/storage_management.dart';
import '../domain/notification_model.dart';
import 'notification_service.dart';
import 'notification_storage_service.dart';

class StompService {
  static final StompService _instance = StompService._internal();

  factory StompService() => _instance;
  StompService._internal();

  StompClient? _client;
  bool _connected = false;

  late BuildContext _context;

  void init(BuildContext context) {
    _context = context;
    connect();
  }

  void connect() {
    if (_connected) return;

    _client = StompClient(
      config: StompConfig(
        url: ApiUrl.stompWSUrl,
        onConnect: _onConnect,
        onWebSocketError: (error) => debugPrint(' WebSocket error: $error'),
        onStompError: (frame) => debugPrint(' STOMP error: ${frame.body}'),
        onDisconnect: (_) {
          _connected = false;
          debugPrint('🔌 Déconnecté');
        },
        onDebugMessage: (msg) => debugPrint('[DEBUG] $msg'),
        reconnectDelay: const Duration(seconds: 5),
      ),
    );

    _client!.activate();
  }

  void _onConnect(StompFrame frame) {
    debugPrint('✅ Connecté à STOMP');
    _connected = true;

    _client!.subscribe(
      destination: '/topic/notifyMobile',
      callback: (frame) async {
        if (frame.body != null) {
          debugPrint('📥 Notification reçue : ${frame.body}');
          try {
            final Map<String, dynamic> notif = jsonDecode(frame.body!);
            notif['dateNotif'] = DateTime.now().toIso8601String();

            // tester si l'email est le mail de l'utilisateur
            // recuperer le mail dans le local storage
            final userEmail = await StorageManagement.getStorage("email");
            if (userEmail == notif["email"]) {
              // Ajouter à la liste des notifications
              final model = Provider.of<NotificationModel>(
                _context,
                listen: false,
              );
              model.add(notif);
              await NotificationStorageService.saveNotification(notif);
              String titleNotif = "Nouvelle notification";

              // Notification système
              if (notif['notificationType'] != null) {
                if (notif['notificationType'] == "transaction") {
                  titleNotif = "Mise à jour transaction";
                }
                if (notif['notificationType'] == "reclamation") {
                  titleNotif = "Mise à jour réclamation";
                }
              }
              NotificationService.show(titleNotif, notif['message']);
            }
          } catch (e) {
            debugPrint('⚠️ Erreur de parsing de notification : $e');
          }
        }
      },
    );
  }

  void disconnect() {
    _client?.deactivate();
    _connected = false;
  }
}