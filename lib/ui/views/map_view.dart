import 'package:countries_world_map/countries_world_map.dart';
import 'package:flutter/material.dart';

import '../../core/models/map_model.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/map_utils.dart';


class MainMapView extends StatefulWidget {

  final MapModel map;

  final Function(String) onCountryTap;

  const MainMapView({Key? key, required this.onCountryTap, required this.map}) : super(key: key);

  @override
  _MainMapViewState createState() => _MainMapViewState();
}

class _MainMapViewState extends State<MainMapView> {

  late String hoverCountry;

  @override
  void initState() {
    hoverCountry = widget.map.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.mainBlueLight.withOpacity(0.5),
              padding: const EdgeInsets.all(16),
              child: SimpleMap(
                onHover: (id, name, tapDetails) {
                  setState(() {
                    if(widget.map.name == "" || widget.map.name == "Spain") {
                      if(widget.map.colors![id] != null) {
                        widget.map.colors![id] = tapDetails ? widget.map.colors![id].withOpacity(0.5) : widget.map.colors![id].withOpacity(1);
                        if(widget.map.name == "Spain") {
                          hoverCountry = tapDetails ? name : "Spain";
                        } else {
                          hoverCountry = tapDetails ? MapUtils.getMapInfo(id).name : "";
                        }
                      }
                    } else {
                      hoverCountry = tapDetails ? name : widget.map.name;
                    }
                  });

                },
                defaultColor: Colors.grey.shade300,
                instructions: widget.map.instructions,
                colors: widget.map.colors,
                callback: (id, name, tapDetails) async {

                  if(widget.map.name == "") {
                    widget.onCountryTap(id);
                  } else {
                    widget.onCountryTap(name);
                  }

                },
              ),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                width: 200,
                height: 50,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      color: AppColors.mainBlueDark,
                      width: 2
                  ),
                ),
                child: Center(
                  child: Text(
                    hoverCountry,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.mainBlueDark,
                    ),
                  ),
                ),
              ),

            )
          )
        ]
    );
  }
}
