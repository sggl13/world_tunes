// bottom_play_bar.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/radio_model.dart';
import '../../core/providers/radio_provider.dart';
import '../../core/utils/app_colors.dart';

class BottomPlayBar extends StatefulWidget {

  final RadioProvider radioProvider;

  BottomPlayBar({
    required this.radioProvider,
  });

  @override
  _BottomPlayBarState createState() => _BottomPlayBarState();
}

class _BottomPlayBarState extends State<BottomPlayBar> {

  double valume = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioProvider>(
      builder: (context, provider, child) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.075,
          color: AppColors.mainBlueDark,
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 250,
                child: Text(
                  "Now Playing: ${provider.currentStationName}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      if(provider.currentStationUrl.isNotEmpty) {
                        provider.togglePlay();
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: Icon(
                        provider.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: AppColors.mainBlueDark,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "   Volume:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                activeTrackColor: AppColors.mainBlueLight,
                                inactiveTrackColor: Colors.white,
                                trackShape: const RectangularSliderTrackShape(),
                                trackHeight: 2.0,
                                thumbColor: AppColors.mainBlueDark.withOpacity(0.5),
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                overlayShape: SliderComponentShape.noOverlay
                            ),
                            child: Slider(
                              value: valume,
                              onChanged: (value) {
                                setState(() {
                                  valume = value;
                                  provider.setVolume(value);
                                });
                              },
                              min: 0,
                              max: 1,
                              divisions: 100,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${(valume * 100).toInt()}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        ]
                      )
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if(provider.isFavorite(provider.currentStationUrl)) {
                    provider.removeFavoriteStation(provider.currentStationUrl, provider.currentRegion);
                  } else {
                    RadioStation radio = RadioStation(
                      name: provider.currentStationName,
                      streamUrl: provider.currentStationUrl,
                    );
                    provider.addFavoriteStation(radio, provider.currentRegion);
                  }

                },
                child: (provider.isFavorite(provider.currentStationUrl))
                    ? const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 30,
                      )
                    : const Icon(
                        Icons.star_border,
                        color: Colors.white,
                        size: 30,
                      ),
              )
            ],
          ),
        );
    });
  }

}
