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
      answer:
          'Open the app and tap "Scan Plant" on the home screen. Point your camera at the plant and take a photo. The AI will analyze the image and provide a diagnosis.',
    ),
    FaqItem(
      question: 'How accurate is the plant diagnosis?',
      answer:
          'Our AI model has been trained on thousands of plant images and achieves over 90% accuracy. However, for critical decisions, we recommend consulting a professional agronomist.',
    ),
    // FaqItem(
    //   question: 'Can I use the app offline?',
    //   answer:
    //       'Some features like viewing past scans are available offline. However, new plant scans and AI Chat require an internet connection.',
    // ),
    FaqItem(
      question: 'How do I chat with the AI assistant?',
      answer:
          'Tap the chat icon in the bottom navigation bar or the "AI Chat" button on the home screen. Type your question and the assistant will respond with farming advice.',
    ),
    FaqItem(
      question: 'How do I update my profile?',
      answer:
          'Go to Settings → Account → My Profile. Tap the "Edit" button in the top right corner to update your name, email, or location.',
    ),
    FaqItem(
      question: 'Is my data secure?',
      answer:
          'Yes. We use industry-standard encryption to protect your data. We never sell your personal information to third parties.',
    ),
    FaqItem(
      question: 'How do I delete my account?',
      answer:
          'Go to Settings → Account → scroll to the bottom and tap "Delete Account". Note that this action is irreversible and all your data will be permanently deleted.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Help & FAQ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2E9E47),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.help_outline, color: Colors.white, size: 32),
                  SizedBox(height: 10),
                  Text(
                    'How can we help?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Find answers to common questions below.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.only(left: 2, bottom: 8),
              child: Text(
                'FREQUENTLY ASKED QUESTIONS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9E9E9E),
                  letterSpacing: 0.8,
                ),
              ),
            ),

            // FAQ List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _faqs.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Color(0xFFEEEEEE),
                ),
                itemBuilder: (context, index) {
                  return FaqTile(item: _faqs[index]);
                },
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                Icon(
                  widget.item.isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF9E9E9E),
                  size: 20,
                ),
              ],
            ),
            if (widget.item.isExpanded) ...[
              const SizedBox(height: 10),
              Text(
                widget.item.answer,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF666666),
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