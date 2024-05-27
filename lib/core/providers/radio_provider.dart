
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../enums/response_state.dart';
import '../models/radio_model.dart';
import '../services/api_service.dart';
import '../utils/view_state.dart';

class RadioProvider with ChangeNotifier {

  List<RadioStation> _stations = [];
  List<RadioStation> get stations => _stations;

  String _currentStationUrl = '';
  String get currentStationUrl => _currentStationUrl;

  String _currentStationName = '';
  String get currentStationName => _currentStationName;

  String _currentRegion = '';
  String get currentRegion => _currentRegion;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  double _volume = 1.0;
  double get volume => _volume;

  Map<String, List<RadioStation>> _favoriteStations = {};
  Map<String, List<RadioStation>> get favoriteStations => _favoriteStations;
  set favoriteStations(Map<String, List<RadioStation>> value) {
    _favoriteStations = value;
    notifyListeners();
  }

  ViewState<dynamic> _viewState = ViewState(state: ResponseState.EMPTY);
  ViewState<dynamic> get viewState => _viewState;
  set viewState(ViewState<dynamic> viewState) {
    _viewState = viewState;
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  RadioProvider() {
    _loadFavoriteStations();
  }

  Future<void> _loadFavoriteStations() async {
    try {
      final box = await Hive.openBox<List>('favoriteStationsBox');
      final Map<dynamic, dynamic> favoriteStationsMap = box.toMap();

      _favoriteStations = favoriteStationsMap.map<String, List<RadioStation>>((key, value) {
        return MapEntry(
            key as String,
            List<RadioStation>.from(value.map((item) => item as RadioStation))
        );
      });

      print('Favorite stations loaded successfully.');
    } catch (e) {
      print('Error loading favorite stations: $e');
    }

    notifyListeners();
  }

  Future<void> _saveFavoriteStations() async {
    try {
      final box = await Hive.openBox<List>('favoriteStationsBox');
      final favoriteStationsMap = _favoriteStations.map((key, value) =>
          MapEntry(key, value.map((station) => station).toList()));
      await box.putAll(favoriteStationsMap);
      print('Favorite stations saved successfully.');
    } catch (e) {
      print('Error saving favorite stations: $e');
    }
  }

  Future<void> fetchRadios(String region) async {
    viewState = ViewState.loading();

    List<RadioStation>? radios = await ApiServices.fetchRadios(country: region);

    if (radios != null) {
      _stations = radios;
      if(radios.isNotEmpty) {
        viewState = ViewState.complete(radios);
      } else {
        viewState = ViewState.empty();
      }
    } else {
      viewState = ViewState.error("Couldn't load $_currentStationName radio.");
      //throw Exception('Failed to load radio stations');
    }

    notifyListeners();
  }

  void playRadio(String url, String name, String country) async {
    try{
      await _audioPlayer.play(url);
      setVolume(_volume);
      _isPlaying = true;
      _currentStationUrl = url;
      _currentStationName = name;
      _currentRegion = country;
    } catch (e) {
      print('Error playing radio: $e');
    }

    notifyListeners();
  }

  void togglePlay() async {
    isPlaying = !isPlaying;

    try{
      if (isPlaying) {
        await _audioPlayer.resume();
      } else {
        await _audioPlayer.pause();
      }
    } catch (e) {
      print('Error toggling play: $e');
    }

    notifyListeners();
  }

  void setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
      _volume = volume;
    } catch (e) {
      print('Error setting volume: $e');
    }

    notifyListeners();
  }

  void removeFavoriteStation(String streamUrl, String region) {
    if (_favoriteStations.containsKey(region)) {
      _favoriteStations[region]!.removeWhere((s) => s.streamUrl == streamUrl);
      _saveFavoriteStations();
      notifyListeners();
    }
  }

  void addFavoriteStation(RadioStation radio, String region) {
    if (!_favoriteStations.containsKey(region)) {
      _favoriteStations[region] = [];
    }
    _favoriteStations[region]!.add(radio);
    _saveFavoriteStations();
    notifyListeners();
  }

  bool isFavorite(String streamUrl) {
    for (final region in _favoriteStations.keys) {
      if (_favoriteStations[region]!.any((s) => s.streamUrl == streamUrl)) {
        return true;
      }
    }

    return false;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
