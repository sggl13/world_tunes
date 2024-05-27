
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enums/response_state.dart';
import '../../core/models/map_model.dart';
import '../../core/providers/radio_provider.dart';
import '../../core/utils/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/radio_tile.dart';
import 'map_view.dart';

class RadioListView extends StatefulWidget {

  final MapModel map;
  final RadioProvider radioProvider;

  const RadioListView({Key? key, required this.map, required this.radioProvider}) : super(key: key);

  @override
  _RadioListViewState createState() => _RadioListViewState();
}

class _RadioListViewState extends State<RadioListView> {

  String currentRegion = "National";

  @override
  void initState() {
    super.initState();
    Provider.of<RadioProvider>(context, listen: false).fetchRadios(widget.map.name.toLowerCase());
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<RadioProvider>(
      builder: (context, provider, child) {
        return _buildBody(provider);
      },
    );
  }


  Widget _buildBody(RadioProvider provider) {
    return Container(
        width: MediaQuery.of(context).size.width - 350,
        height: MediaQuery.of(context).size.height * 0.925,
        child: Row(
          children: [
            Expanded(
              child: MainMapView(
                map: widget.map,
                onCountryTap: (String region) async {
                  await provider.fetchRadios(region.toLowerCase());
                  setState(() {
                    currentRegion = region;
                  });
                },
              ),
            ),
            Container(
              width: 400,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      '${widget.map.name} Tunes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: AppColors.mainBlueDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Currently viewing $currentRegion radio stations.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.mainOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: _getRadioState(provider),
                  )
                ],
              ),
            )
          ],
        )
    );
  }


  Widget _getRadioState(RadioProvider provider) {
    switch (provider.viewState.state) {
      case ResponseState.LOADING:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.mainBlueDark,),
              const SizedBox(height: 16),
              const Text('Fetching radio stations...'),
            ],
          )
        );
      case ResponseState.ERROR:
        return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red.withOpacity(0.5), size: 40),
                const SizedBox(height: 16),
                const Text('Error fetching radio stations. Please try again.'),
                const SizedBox(height: 16),
                CustomButton(
                  width: 200,
                  height: 41,
                  onPressed: () async {await provider.fetchRadios(widget.map.name.toLowerCase());},
                  primaryColor: AppColors.mainBlueDark,
                  hoverColor: AppColors.mainBlueDark.withOpacity(0.75),
                  text: const Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  iconEnd: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
          )
        );
      case ResponseState.EMPTY:
        return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.radio, color: AppColors.mainBlueDark.withOpacity(0.5), size: 40),
                const SizedBox(height: 16),
                const Text('No radio stations found.'),
              ],
          )
        );
      case ResponseState.COMPLETE:
        return SingleChildScrollView(
          child: Column(
              children: [
                for (final radio in provider.stations) ...[
                  RadioTile(radio: radio, radioProvider: provider, country: widget.map.name,),
                  const SizedBox(height: 8),
                ]
              ]
          ),
        );
    }
  }

}
