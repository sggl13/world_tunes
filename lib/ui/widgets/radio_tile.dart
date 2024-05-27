
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/radio_model.dart';
import '../../core/providers/radio_provider.dart';
import '../../core/utils/app_colors.dart';

class RadioTile extends StatefulWidget {

  final RadioStation radio;
  final RadioProvider radioProvider;
  final String country;

  const RadioTile({
    Key? key,
    required this.radio,
    required this.radioProvider,
    required this.country,
  }) : super(key: key);

  @override
  _RadioTileState createState() => _RadioTileState();
}


class _RadioTileState extends State<RadioTile> {

  late Color _color;

  @override
  void initState() {
    _color = AppColors.mainBlueLight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RadioProvider>(
      builder: (context, provider, child) {
        return MouseRegion(
          onEnter: (event) {
            setState(() {
              _color = _color.withOpacity(0.5);
            });
          },
          onExit: (event) {
            setState(() {
              _color = _color.withOpacity(1);
            });
          },
          child: Container(
            width: 350,
            height: 41,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.mainBlueDark,
                width: 2,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    widget.radio.name,
                    style: TextStyle(
                      color: AppColors.mainBlueDark,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    if(widget.radioProvider.currentStationUrl == widget.radio.streamUrl && widget.radioProvider.isPlaying) {
                      widget.radioProvider.togglePlay();
                    } else {
                      if(widget.radioProvider.isPlaying) {
                        widget.radioProvider.togglePlay();
                      }
                      widget.radioProvider.playRadio(widget.radio.streamUrl, widget.radio.name, widget.country);
                    }

                  },
                  child: (widget.radioProvider.currentStationUrl == widget.radio.streamUrl && widget.radioProvider.isPlaying)
                    ? Icon(
                        Icons.pause,
                        color: AppColors.mainBlueDark,
                        size: 20,
                      )
                    : Icon(
                        Icons.play_arrow,
                        color: AppColors.mainBlueDark,
                        size: 20,
                      ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    if(widget.radioProvider.isFavorite(widget.radio.streamUrl)) {
                      widget.radioProvider.removeFavoriteStation(widget.radio.streamUrl, widget.country);
                    } else {
                      widget.radioProvider.addFavoriteStation(widget.radio, widget.country);
                    }

                  },
                  child: (widget.radioProvider.isFavorite(widget.radio.streamUrl))
                    ? Icon(
                        Icons.star,
                        color: AppColors.mainBlueDark,
                        size: 16,
                      )
                    : Icon(
                        Icons.star_border,
                        color: AppColors.mainBlueDark,
                        size: 16,
                      ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}