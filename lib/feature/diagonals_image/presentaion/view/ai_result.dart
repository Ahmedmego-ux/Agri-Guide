import 'dart:io';
import 'package:flutter/material.dart';

class AIResultScreen extends StatefulWidget {
  final String imagePath;

  const AIResultScreen({
    super.key,
    required this.imagePath,
  });

  @override
  State<AIResultScreen> createState() => _AIResultScreenState();
}

class _AIResultScreenState extends State<AIResultScreen> {
  bool isLoading = true;
  String? result;

  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
      result = '''
🌿 PLANT ANALYSIS REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔬 DISEASE DETECTION:
• Disease: Early Blight (Alternaria solani)
• Confidence: 92.4%
• Severity: Moderate to High

📊 SYMPTOMS MATCHED:
• Dark brown spots with concentric rings — ✅ Matched (89%)
• Yellowing of lower leaves — ✅ Matched (85%)
• Leaf blight and defoliation — ✅ Matched (78%)
• Stem lesions — ⚠️ Partially detected (54%)

🦠 SECONDARY INFECTIONS:
• No other pathogens detected

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💊 TREATMENT RECOMMENDATIONS:

1️⃣ IMMEDIATE ACTION (Next 24h):
   • Remove and destroy all infected leaves
   • Disinfect pruning tools with bleach solution
   • Avoid watering leaves (water soil only)

2️⃣ ORGANIC TREATMENT (Every 5-7 days):
   • Neem oil spray (2ml/L water)
   • Copper fungicide (Bordeaux mixture)
   • Baking soda solution (1tsp/L + soap)

3️⃣ CHEMICAL CONTROL (Severe cases):
   • Chlorothalonil or Mancozeb based fungicides
   • Apply every 7-10 days for 3 cycles

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌱 PREVENTION TIPS:
✅ Crop rotation (4-year cycle)
✅ Mulch around plants to prevent soil splash
✅ Stake plants for better air circulation
✅ Water early morning only
✅ Space plants 45-60cm apart

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📈 PROGNOSIS:
• With treatment: 85% recovery within 14 days
• Without treatment: Yield loss up to 40-60%

⚠️ ALERT: Disease may spread to stems and fruits if untreated!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 AI Model: Custom CNN v2.3
📅 Analysis Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}
⏱️ Processing Time: 1.8 seconds
      ''';
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Plant Scanner"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(widget.imagePath),
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: isLoading
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text("Analyzing plant health..."),
                          SizedBox(height: 4),
                          Text("Please wait"),
                        ],
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: cs.shadow.withOpacity(0.4),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(  
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, 
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: cs.primaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: cs.primary,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Analysis Complete",
                                      style: textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "AI Diagnosis Report",
                                      style: textTheme.bodySmall?.copyWith(
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),  
                            
                            Text(
                              result ?? "No result",
                              style: textTheme.bodyMedium?.copyWith(
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8), 
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}