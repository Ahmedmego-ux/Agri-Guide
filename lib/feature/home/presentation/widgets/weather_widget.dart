// lib/feature/home/presentation/widgets/weather_widget.dart

import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '32°C',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: cs.onPrimary,
                    ),
                  ),
                  Text(
                    'Sunny',
                    style: TextStyle(
                      fontSize: 14,
                      color: cs.onPrimary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.wb_sunny, color: Colors.amber, size: 48),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStat(cs, Icons.water_drop_outlined, '65%', 'Humidity'),
              _buildStat(cs, Icons.air, '12 km/h', 'Wind'),
              _buildStat(cs, Icons.umbrella_outlined, '10%', 'Rain'),
              _buildStat(cs, Icons.wb_sunny_outlined, 'High', 'UV'),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: const Border(
                left: BorderSide(color: Colors.amber, width: 3),
              ),
            ),
            child: Text(
              'Good day for morning irrigation before temperatures rise',
              style: TextStyle(
                fontSize: 12,
                color: Colors.amber.shade200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(ColorScheme cs, IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: cs.onPrimary, size: 16),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: cs.onPrimary,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: cs.onPrimary.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}