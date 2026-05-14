import 'package:agri_guide_app/feature/chat_bot/domain/entity/chat_session_entity.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/message/chat_cubit.dart';
import 'package:agri_guide_app/feature/chat_bot/presentation/manger/session/session_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
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

            padding: const EdgeInsets.fromLTRB(
              16,
              50,
              16,
              16,
            ),

            color: cs.primary,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                CircleAvatar(
                  radius: 30,

                  backgroundColor:
                      cs.onPrimary.withOpacity(0.2),

                  child: Icon(
                    Icons.smart_toy,
                    color: cs.onPrimary,
                    size: 30,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'previousChats'.tr(),
                  style:
                      theme.appBarTheme.titleTextStyle,
                ),

                BlocBuilder<
                    SessionCubit,
                    SessionState>(
                  builder: (context, state) {
                    final count =
                        state is SessionSuccess
                            ? state.sessions.length
                            : 0;

                    return Text(
                      '$count ${'conversations'.tr()}',

                      style: TextStyle(
                        color:
                            cs.onPrimary.withOpacity(
                          0.7,
                        ),
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<
                SessionCubit,
                SessionState>(
              builder: (context, state) {
                if (state is SessionLoading) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                if (state is SessionSuccess) {
                  if (state.sessions.isEmpty) {
                    return Center(
                      child: Text(
                        'noConversationsYet'.tr(),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,

                    itemCount: state.sessions.length,

                    separatorBuilder: (_, __) =>
                        Divider(
                      height: 1,
                      indent: 72,
                      color:
                          theme.dividerTheme.color,
                    ),

                    itemBuilder: (context, index) {
                      final session =
                          state.sessions[index];

                      return _buildChatTile(
                        session,
                        context,
                      );
                    },
                  );
                }

                if (state is SessionFailure) {
                  return Center(
                    child: Text(
                      '${'error'.tr()}: ${state.errmessage}',

                      style: TextStyle(
                        color: cs.error,
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),

            child: ElevatedButton.icon(
              icon: Icon(
                Icons.add,
                color: cs.onPrimary,
              ),

              label: Text(
                'newChat'.tr(),

                style: TextStyle(
                  color: cs.onPrimary,
                  fontSize: 16,
                ),
              ),

              onPressed: () async {
                await context
                    .read<ChatCubit>()
                    .startNewChat();

                await context
                    .read<SessionCubit>()
                    .getSessions();

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(
    ChatSessionEntity session,
    BuildContext context,
  ) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),

      leading: CircleAvatar(
        backgroundColor: cs.primaryContainer,

        child: Icon(
          Icons.smart_toy,
          color: cs.onPrimaryContainer,
        ),
      ),

      title: Text(
        session.title,

        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: cs.onSurface,
        ),

        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      subtitle: Text(
        _formatDate(session.createdAt),

        maxLines: 1,
        overflow: TextOverflow.ellipsis,

        style: TextStyle(
          color: cs.onSurfaceVariant,
          fontSize: 12,
        ),
      ),

      onTap: () async {
        if (!context.mounted) return;

        context
            .read<ChatCubit>()
            .loadMessages(session.id);

        await context
            .read<SessionCubit>()
            .getSessions();

        if (!context.mounted) return;

        Navigator.pop(context);
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();

    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${'today'.tr()}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'yesterday'.tr();
    } else if (difference.inDays < 7) {
      final days = [
        'monday'.tr(),
        'tuesday'.tr(),
        'wednesday'.tr(),
        'thursday'.tr(),
        'friday'.tr(),
        'saturday'.tr(),
        'sunday'.tr(),
      ];

      return days[date.weekday - 1];
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}