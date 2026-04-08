import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/home/presentation/enums/weather_enum.dart';
import 'package:agri_guide_app/feature/home/presentation/manger/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key, required this.latitude, required this.longitude,});
final double latitude;
final double longitude;

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  
  @override
void initState() {
  super.initState();

  context.read<WeatherCubit>().getWeather(widget.latitude, widget.longitude);
}
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WeatherFaliure) {
          return const Center(
            child: Text("Weather data is not available"),
          );
        }

        if (state is WeatherSuccess) {
          final weather = state.weather;
          final weatherEnum = weather.condition;

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
                          "${weather.temperature.toInt()}°",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: cs.onPrimary,
                          ),
                        ),
                        Text(
                          weatherEnum.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: cs.onPrimary.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                   
                    Icon(
                      weatherEnum.icon,
                      color: weatherEnum.iconColor,
                      size: 48,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                
                Row(
                  children: [
                    _buildStat(
                      cs,
                      Icons.water_drop_outlined,
                      "${weather.soilMoisture.toStringAsFixed(1)}",
                      "Soil",
                    ),
                    _buildStat(
                      cs,
                      Icons.air,
                      "${weather.windSpeed.toInt()} km/h",
                      "Wind",
                    ),
                    _buildStat(
                      cs,
                      Icons.umbrella_outlined,
                      "${weather.rainChance.toInt()}%",
                      "Rain",
                    ),
                    _buildStat(
                      cs,
                      Icons.wb_sunny_outlined,
                      weather.uvIndex.toString(),
                      "UV",
                    ),
                  ],
                ),

                const SizedBox(height: 10),

             
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: weatherEnum.iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      left: BorderSide(
                        color: weatherEnum.iconColor,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    weatherEnum.tip,
                    style: TextStyle(
                      fontSize: 12,
                      color: cs.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildStat(
    ColorScheme cs,
    IconData icon,
    String value,
    String label,
  ) {
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