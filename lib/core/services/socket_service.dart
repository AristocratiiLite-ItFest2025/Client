import 'package:socket_io_client/socket_io_client.dart' as io;

final String baseUrl = 'https://backend-helpnow.city-aura.co';

class SocketService {
  late io.Socket socket;

  SocketService() {
    socket = io.io(
      baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // We'll connect manually.
          .build(),
    );
    socket.connect();
  }

  void joinChat(int chatId) {
    socket.emit('join', {"chat_id": chatId});
  }

  void leaveChat(int chatId) {
    socket.emit('leave', {"chat_id": chatId});
  }

  void listenForMessages(void Function(dynamic) onMessage) {
    socket.on('message', (data) {
      onMessage(data);
    });
  }

  void sendMessage(Map<String, dynamic> message) {
    socket.emit('message', message);
  }
}
