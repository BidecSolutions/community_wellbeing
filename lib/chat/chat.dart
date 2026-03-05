import 'package:community_app/app_settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});



  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late io.Socket socket;
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  void initSocket() {
    socket = io.io(AppSettings.baseUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      socket.on('chat_${2}', (data) {
        setState(() {
          messages.add('${data['from']}: ${data['text']}');
        });
      });
    });

    // socket.onDisconnect((_) => print('${2} disconnected'));
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    socket.emit('send_message', {
      'from': 1,
      'to': 2,
      'text': text,
    });

    setState(() {
      messages.add('You: $text');
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: messages.map((msg) => Text(msg)).toList(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(child: TextField(controller: controller)),
            IconButton(icon: const Icon(Icons.send), onPressed: sendMessage),
          ],
        ),
      ),
    ],
  );
}
