import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelpFaqView extends StatefulWidget {
  const HelpFaqView({super.key});

  @override
  State<HelpFaqView> createState() => _HelpFaqViewState();
}

class _HelpFaqViewState extends State<HelpFaqView> {
  final List<FaqItem> _faqs = [
    FaqItem(
      question: 'faqQuestion1'.tr(),
      answer: 'faqAnswer1'.tr(),
    ),
    FaqItem(
      question: 'faqQuestion2'.tr(),
      answer: 'faqAnswer2'.tr(),
    ),
    FaqItem(
      question: 'faqQuestion3'.tr(),
      answer: 'faqAnswer3'.tr(),
    ),
    FaqItem(
      question: 'faqQuestion4'.tr(),
      answer: 'faqAnswer4'.tr(),
    ),
    FaqItem(
      question: 'faqQuestion5'.tr(),
      answer: 'faqAnswer5'.tr(),
    ),
    FaqItem(
      question: 'faqQuestion6'.tr(),
      answer: 'faqAnswer6'.tr(),
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
          icon: Icon(
            Directionality.of(context) == TextDirection.RTL
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_rounded,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('helpFaq'.tr()),
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
                  Icon(Icons.help_outline,
                      color: cs.onPrimary, size: 32),
                  const SizedBox(height: 10),
                  Text(
                    'howCanWeHelp'.tr(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'faqSubtitle'.tr(),
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
                'faqTitle'.tr(),
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
                itemBuilder: (context, index) =>
                    FaqTile(item: _faqs[index]),
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

  FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
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
      onTap: () => setState(
        () => widget.item.isExpanded = !widget.item.isExpanded,
      ),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
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
                  widget.item.isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
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