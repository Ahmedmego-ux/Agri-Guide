import 'package:flutter/material.dart';

class DrawerChats extends StatelessWidget {
  const DrawerChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
  child: Column(
    children: [
      // ===== Header =====
      Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
        color: const Color(0xff00A63E),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 12),
            const Text(
              'Previous Chats',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '3 conversations',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),

      // ===== Chat List =====
      Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildChatTile(
              title: 'AI Assistant',
              subtitle: 'Hello! How can I help...',
              time: '02:06',
              unread: 2,
              context: context,
            ),
            const Divider(height: 1, indent: 72),
            _buildChatTile(
              title: 'Plant Doctor',
              subtitle: 'Your plant is healthy!',
              time: 'Yesterday',
              unread: 0,
              context: context,
            ),
            const Divider(height: 1, indent: 72),
            _buildChatTile(
              title: 'Weather Bot',
              subtitle: 'Rain expected tomorrow',
              time: 'Mon',
              unread: 1, context: context,
            ),
          ],
        ),
      ),

      // ===== New Chat Button =====
      Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff00A63E),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            'New Chat',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    ],
  ),
);
  }
  Widget _buildChatTile({
  required String title,
  required String subtitle,
  required String time,
  required int unread,
 required BuildContext context,
}) {
  
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    leading: CircleAvatar(
      backgroundColor: const Color(0xff00A63E).withOpacity(0.1),
      child: const Icon(Icons.smart_toy, color: Color(0xff00A63E)),
    ),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
    subtitle: Text(
      subtitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey[600], fontSize: 12),
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: TextStyle(
            fontSize: 11,
            color: unread > 0 ? const Color(0xff00A63E) : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        if (unread > 0)
          CircleAvatar(
            radius: 9,
            backgroundColor: const Color(0xff00A63E),
            child: Text(
              unread.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
    onTap: () => Navigator.pop(context),
  );
}
}

