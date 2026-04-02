import 'package:flutter/material.dart';

class DrawerChats extends StatelessWidget {
  const DrawerChats({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            color: cs.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: cs.onPrimary.withOpacity(0.2),
                  child: Icon(Icons.smart_toy, color: cs.onPrimary, size: 30),
                ),
                const SizedBox(height: 12),
                Text(
                  'Previous Chats',
                  style: theme.appBarTheme.titleTextStyle,
                ),
                Text(
                  '3 conversations',
                  style: TextStyle(color: cs.onPrimary.withOpacity(0.7), fontSize: 12),
                ),
              ],
            ),
          ),
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
                Divider(height: 1, indent: 72, color: theme.dividerTheme.color),
                _buildChatTile(
                  title: 'Plant Doctor',
                  subtitle: 'Your plant is healthy!',
                  time: 'Yesterday',
                  unread: 0,
                  context: context,
                ),
                Divider(height: 1, indent: 72, color: theme.dividerTheme.color),
                _buildChatTile(
                  title: 'Weather Bot',
                  subtitle: 'Rain expected tomorrow',
                  time: 'Mon',
                  unread: 1,
                  context: context,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add, color: cs.onPrimary),
              label: Text(
                'New Chat',
                style: TextStyle(color: cs.onPrimary, fontSize: 16),
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
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: cs.primaryContainer,
        child: Icon(Icons.smart_toy, color: cs.onPrimaryContainer),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: cs.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 11,
              color: unread > 0 ? cs.primary : cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          if (unread > 0)
            CircleAvatar(
              radius: 9,
              backgroundColor: cs.primary,
              child: Text(
                unread.toString(),
                style: TextStyle(
                  color: cs.onPrimary,
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