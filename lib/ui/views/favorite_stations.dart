
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/radio_provider.dart';
import '../../core/utils/app_colors.dart';
import '../widgets/radio_tile.dart';

class FavoriteRadios extends StatefulWidget {
  @override
  _FavoriteRadiosState createState() => _FavoriteRadiosState();
}

class _FavoriteRadiosState extends State<FavoriteRadios> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RadioProvider>(
      builder: (context, provider, child) {
        return Container(
          width: MediaQuery.of(context).size.width - 350,
          height: MediaQuery.of(context).size.height * 0.925,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Favorite Radios",
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.mainOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(final region in provider.favoriteStations.keys)...[
                      if(provider.favoriteStations[region]!.isNotEmpty)...[
                        Text(
                          region,
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.mainBlueDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Divider(color: AppColors.mainBlueDark.withOpacity(0.5),),
                        const SizedBox(height: 8),
                        for(final radio in provider.favoriteStations[region]!)...[
                          RadioTile(radio: radio, radioProvider: provider, country: region,),
                          const SizedBox(height: 8),
                        ],
                        const SizedBox(height: 32),
                      ]
                    ]
                  ]
                ),
              )
            ],
          ),
        );
      },
    );
  }
}