import 'package:agri_guide_app/feature/chat_bot/domain/entity/chat_session_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/message/chat_cubit.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerChats extends StatefulWidget {
  const DrawerChats({super.key});

  @override
  State<DrawerChats> createState() => _DrawerChatsState();
}

class _DrawerChatsState extends State<DrawerChats> {
  @override
  void initState() {
    super.initState();
    // ✅ جيب المحادثات لما الـ Drawer يفتح
    context.read<SessionCubit>().getSessions();
  }

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
                Text('Previous Chats', style: theme.appBarTheme.titleTextStyle),
                BlocBuilder<SessionCubit, SessionState>(
                  builder: (context, state) {
                    final count = state is SessionSuccess ? state.sessions.length : 0;
                    return Text(
                      '$count conversations',
                      style: TextStyle(color: cs.onPrimary.withOpacity(0.7), fontSize: 12),
                    );
                  },
                ),
              ],
            ),
          ),

          // ✅ قايمة المحادثات
          Expanded(
            child: BlocBuilder<SessionCubit, SessionState>(
              builder: (context, state) {
                if (state is SessionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SessionSuccess) {
                  if (state.sessions.isEmpty) {
                    return const Center(child: Text('No conversations yet'));
                  }
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: state.sessions.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      indent: 72,
                      color: theme.dividerTheme.color,
                    ),
                    itemBuilder: (context, index) {
                      final session = state.sessions[index];
                      return _buildChatTile(session, context);
                    },
                  );
                }
                if (state is SessionFailure) {
                  return Center(
                    child: Text(
                      'Error: ${state.errmessage}',
                      style: TextStyle(color: cs.error),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          // ✅ زر New Chat (معدل)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add, color: cs.onPrimary),
              label: Text('New Chat', style: TextStyle(color: cs.onPrimary, fontSize: 16)),
              onPressed: () async {
                // ✅ حفظ الشات الحالي ثم إنشاء شات جديد
                await context.read<ChatCubit>().startNewChat();
                // ✅ تحديث قائمة الجلسات
                await context.read<SessionCubit>().getSessions();
                // ✅ إغلاق الـ Drawer
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(ChatSessionEntity session, BuildContext context) {
    final cs = Theme.of(context).colorScheme;

   return ListTile(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  leading: CircleAvatar(
    backgroundColor: cs.primaryContainer,
    child: Icon(Icons.smart_toy, color: cs.onPrimaryContainer),
  ),
  title: Text(
    session.title,
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: cs.onSurface),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
  subtitle: Text(
    _formatDate(session.createdAt),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
  ),
  onTap: () async {
    // ✅ تحقق من أن الـ widget لا يزال موجوداً
    if (!context.mounted) return;
    
    // ✅ تحميل الجلسة المختارة مباشرة (بدون startNewChat)
    // لأن loadMessages ستقوم بحفظ الجلسة الحالية تلقائياً
    context.read<ChatCubit>().loadMessages(session.id);
    
    // ✅ تحديث قائمة الجلسات
    await context.read<SessionCubit>().getSessions();
    
    // ✅ تحقق قبل إغلاق الـ Drawer
    if (!context.mounted) return;
    Navigator.pop(context);
  },
);
  }

  // ✅ دالة مساعدة لتنسيق التاريخ
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      // اليوم
      return 'Today, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      // أمس
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      // خلال الأسبوع
      final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      return days[date.weekday - 1];
    } else {
      // أقدم من أسبوع
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}