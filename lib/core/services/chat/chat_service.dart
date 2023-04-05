import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';

import 'chat_mock_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messageStream();
  Future<ChatMessage> save(String text, ChatUser user);

  factory ChatService() {
    return ChatMockService();
  }
}
