import 'package:flutter/material.dart';

class HelpFaqView extends StatefulWidget {
  const HelpFaqView({super.key});

  @override
  State<HelpFaqView> createState() => _HelpFaqViewState();
}

class _HelpFaqViewState extends State<HelpFaqView> {
  final List<FaqItem> _faqs = [
    FaqItem(
      question: 'How do I scan a plant?',
      answer: 'Open the app and tap "Scan Plant" on the home screen. Point your camera at the plant and take a photo. The AI will analyze the image and provide a diagnosis.',
    ),
    FaqItem(
      question: 'How accurate is the plant diagnosis?',
      answer: 'Our AI model has been trained on thousands of plant images and achieves over 90% accuracy. However, for critical decisions, we recommend consulting a professional agronomist.',
    ),
    FaqItem(
      question: 'How do I chat with the AI assistant?',
      answer: 'Tap the chat icon in the bottom navigation bar or the "AI Chat" button on the home screen. Type your question and the assistant will respond with farming advice.',
    ),
    FaqItem(
      question: 'How do I update my profile?',
      answer: 'Go to Settings → Account → My Profile. Tap the "Edit" button in the top right corner to update your name, email, or location.',
    ),
    FaqItem(
      question: 'Is my data secure?',
      answer: 'Yes. We use industry-standard encryption to protect your data. We never sell your personal information to third parties.',
    ),
    FaqItem(
      question: 'How do I delete my account?',
      answer: 'Go to Settings → Account → scroll to the bottom and tap "Delete Account". Note that this action is irreversible and all your data will be permanently deleted.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Help & FAQ'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.help_outline, color: cs.onPrimary, size: 32),
                  const SizedBox(height: 10),
                  Text(
                    'How can we help?',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Find answers to common questions below.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onPrimary.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 8),
              child: Text(
                'FREQUENTLY ASKED QUESTIONS',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _faqs.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: theme.dividerTheme.color,
                ),
                itemBuilder: (context, index) => FaqTile(item: _faqs[index]),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;
  bool isExpanded;

  FaqItem({required this.question, required this.answer, this.isExpanded = false});
}

class FaqTile extends StatefulWidget {
  final FaqItem item;
  const FaqTile({super.key, required this.item});

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: () => setState(() => widget.item.isExpanded = !widget.item.isExpanded),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item.question,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                Icon(
                  widget.item.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: cs.onSurfaceVariant,
                  size: 20,
                ),
              ],
            ),
            if (widget.item.isExpanded) ...[
              const SizedBox(height: 10),
              Text(
                widget.item.answer,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}