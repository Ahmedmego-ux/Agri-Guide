import 'package:agri_guide_app/feature/home/presentation/enums/weather_enum.dart';
import 'package:agri_guide_app/feature/home/presentation/manger/cubit/weather_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  State<WeatherWidget> createState() =>
      _WeatherWidgetState();
}

class _WeatherWidgetState
    extends State<WeatherWidget> {
  @override
  void initState() {
    super.initState();

    context.read<WeatherCubit>().getWeather(
          widget.latitude,
          widget.longitude,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Container(
            height: 160,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: cs.primary,
              ),
            ),
          );
        }

        if (state is WeatherFaliure) {
          return Container(
            height: 80,
            decoration: BoxDecoration(
              color: cs.errorContainer,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "weatherNotAvailable".tr(),
                style: TextStyle(
                  color: cs.onErrorContainer,
                ),
              ),
            ),
          );
        }

        if (state is WeatherSuccess) {
          final weather = state.weather;
          final weatherEnum = weather.condition;

          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient:
                  weatherEnum.backgroundGradient,
              borderRadius:
                  BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background decoration circles
                Positioned(
                  top: -30,
                  right: Directionality.of(context) ==
                          TextDirection.RTL
                      ? null
                      : -20,
                  left: Directionality.of(context) ==
                          TextDirection.RTL
                      ? -20
                      : null,
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                          .withOpacity(0.07),
                    ),
                  ),
                ),

                Positioned(
                  bottom: -20,
                  left: Directionality.of(context) ==
                          TextDirection.RTL
                      ? null
                      : -20,
                  right: Directionality.of(context) ==
                          TextDirection.RTL
                      ? -20
                      : null,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                          .withOpacity(0.05),
                    ),
                  ),
                ),

                Column(
                  children: [
                    // Top row: temp + icon
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              "${weather.temperature.toInt()}°",
                              style: TextStyle(
                                fontSize: 52,
                                fontWeight:
                                    FontWeight.w800,
                                color:
                                    cs.onPrimary,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(
                                height: 4),
                            Text(
                              weatherEnum.name
                                  .tr(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w500,
                                color: cs
                                    .onPrimary
                                    .withOpacity(
                                        0.85),
                                letterSpacing:
                                    0.3,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        Icon(
                          weatherEnum.icon,
                          color:
                              weatherEnum.iconColor,
                          size: 60,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Divider
                    Divider(
                      color: Colors.white
                          .withOpacity(0.2),
                      thickness: 1,
                      height: 1,
                    ),

                    const SizedBox(height: 14),

                    // Stats row
                    Row(
                      children: [
                        _buildStat(
                          cs,
                          Icons
                              .water_drop_outlined,
                          weather.soilMoisture
                              .toStringAsFixed(1),
                          "soil".tr(),
                        ),

                        _buildStat(
                          cs,
                          Icons.air,
                          "${weather.windSpeed.toInt()} km/h",
                          "wind".tr(),
                        ),

                        _buildStat(
                          cs,
                          Icons
                              .umbrella_outlined,
                          "${weather.rainChance.toInt()}%",
                          "rain".tr(),
                        ),

                        _buildStat(
                          cs,
                          Icons
                              .wb_sunny_outlined,
                          weather.uvIndex
                              .toString(),
                          "uv".tr(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Tip banner
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.15),
                        border: Border(
                          left: BorderSide(
                            color: weatherEnum
                                .iconColor,
                            width: 3,
                          ),
                        ),
                        borderRadius:
                            BorderRadius.circular(
                                12),
                      ),
                      child: Text(
                        weatherEnum.tip,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w500,
                          color: cs.onPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
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
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 4,
        ),
        margin:
            const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius:
              BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: cs.onPrimary,
              size: 18,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: cs.onPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: cs.onPrimary
                    .withOpacity(0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}