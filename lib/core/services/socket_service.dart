import 'package:socket_io_client/socket_io_client.dart' as io;
import 'preferences_service.dart'; // Import your preferences service.

final String baseUrl = 'https://backend-helpnow.city-aura.co';

class SocketService {
  late io.Socket socket;
  String? userId;

  SocketService() {
    _initializeUserId();
    socket = io.io(
      baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // We'll connect manually.
          .build(),
    );
    socket.connect();
  }

  Future<void> _initializeUserId() async {
    final prefsService = PreferencesService();
    await prefsService.init();
    final profile = prefsService.profile;
    if (profile != null) {
      userId = profile.id as String?;
    }
  }

  void joinChat(int chatId, int userId) {
    socket.emit('join', {"user_id": userId, "chat_id": chatId});
    }

  void leaveChat(int chatId, int userId) {
    socket.emit('leave', {"user_id": userId, "chat_id": chatId});
    }

  void listenForMessages(void Function(dynamic) onMessage) {
    socket.on('message', (data) {
      onMessage(data);
    });
  }

  void sendMessage(message, chatId, userId) {
    socket.emit('message', {"user_id": userId, "chat_id": chatId, "text": message});
  }
}
