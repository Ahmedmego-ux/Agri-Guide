import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  final _bot = const types.User(id: 'bot');

  // ===== Send Text =====
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    setState(() => _messages.insert(0, textMessage));
    _fakeBotReply(message.text);
  }

  // ===== Send Image =====
  void _sendImage(String path) {
    final message = types.ImageMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      name: 'image',
      size: 0,
      uri: path,
    );
    setState(() => _messages.insert(0, message));
  }

  // ===== Attachment =====
  Future<void> _handleAttachmentPressed() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.green),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) _sendImage(image.path);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) _sendImage(image.path);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ===== Bot Reply =====
  Future<void> _fakeBotReply(String userMessage) async {
    await Future.delayed(const Duration(seconds: 1));

    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: "Bot reply to: $userMessage",
    );

    setState(() => _messages.insert(0, botMessage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
  child: ListView(
    children: [
     
       
        const Text(
          ' Chats',
          style: TextStyle(color: Colors.black, ),
        ),
      
      ListTile(
        leading: const Icon(Icons.chat, color: Color(0xff00A63E)),
        title: const Text('Chat 1'),
        onTap: () => Navigator.pop(context),
      ),
    ],
  ),
),
      appBar: AppBar(
actions: [
  IconButton(onPressed: () => _scaffoldKey.currentState?.openEndDrawer(), icon: Icon(Icons.menu,color:Colors.white,size:30))
],
        
        toolbarHeight: 80,
        backgroundColor: const Color(0xff00A63E),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            children: [
               CircleAvatar(
          backgroundColor: Color(0xff008236),
          child: SvgPicture.asset('assets/Icon.svg')),
          SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Assistant',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const Gap(5),
                  const Text(
                    'Always active',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Chat(

        
        showUserAvatars: true,
        
        avatarBuilder: (author) {
        return  CircleAvatar(
          backgroundColor: Color(0xffDCFCE7),
           child: SvgPicture.asset('assets/Icon.svg',color:Color(0xff008236),)
        
        );
        },
        onAttachmentPressed: _handleAttachmentPressed,
        disableImageGallery: true,
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DefaultChatTheme(
          attachmentButtonIcon: Icon(Icons.image,size: 30,color: Colors.grey,),
          primaryColor: Colors.green,
          secondaryColor: const Color(0xffF5F5F5),
          sentMessageBodyTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          inputBackgroundColor: Colors.white,
          inputTextColor: Colors.black,
          inputBorderRadius: BorderRadius.circular(24),
          inputTextDecoration: InputDecoration(
            hintText: 'Ask about your crops...',
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          sendButtonIcon: SvgPicture.asset(
            "assets/send-icon.svg",
            width: 24,
            height: 30,
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}