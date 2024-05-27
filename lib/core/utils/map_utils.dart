
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';

import '../models/map_model.dart';

class MapUtils {


  static MapModel getMapInfo(String country) {

    MapModel mapInfo;

    switch (country) {
      case "es":
        mapInfo = MapModel(
            name: "Spain",
            instructions: SMapSpain.instructions,
            colors: SMapSpainColors(
              esAN: Colors.green,
              esAR: Colors.purple,
              esAS: Colors.blue,
              esCB: Colors.yellow,
              esCM: Colors.pink,
              esCL: Colors.cyan,
              esCT: Colors.brown,
              esEX: Colors.purple,
              esGA: Colors.green,
              esIB: Colors.teal,
              esMC: Colors.lime,
              esMD: Colors.indigo,
              esRI: Colors.red,
              esVC: Colors.blue,
              esPV: Colors.green,
              esCN: Colors.blue,
              esNC: Colors.yellow,
            ).toMap()
        );
        break;
      case "pt":
        mapInfo = MapModel(instructions: SMapPortugal.instructions, colors: null, name: "Portugal");
        break;
      case "fr":
        mapInfo = MapModel(instructions: SMapFrance.instructions, colors: null, name: "France");
        break;
      case "de":
        mapInfo = MapModel(instructions: SMapGermany.instructions, colors: null, name: "Germany");
        break;
      case "it":
        mapInfo = MapModel(instructions: SMapItaly.instructions, colors: null, name: "Italy");
        break;
      case "gr":
        mapInfo = MapModel(instructions: SMapGreece.instructions, colors: null, name: "Greece");
        break;
      case "gb":
        mapInfo = MapModel(instructions: SMapUnitedKingdom.instructions, colors: null, name: "United Kingdom");
        break;
      case "pl":
        mapInfo = MapModel(instructions: SMapPoland.instructions, colors: null, name: "Poland");
        break;
      case "at":
        mapInfo = MapModel(instructions: SMapAustria.instructions, colors: null, name: "Austria");
        break;
      case "au":
        mapInfo = MapModel(instructions: SMapAustralia.instructions, colors: null, name: "Australia");
        break;
      case "no":
        mapInfo = MapModel(instructions: SMapNorway.instructions, colors: null, name: "Norway");
        break;
      case "se":
        mapInfo = MapModel(instructions: SMapSweden.instructions, colors: null, name: "Sweden");
        break;
      case "fi":
        mapInfo = MapModel(instructions: SMapFinland.instructions, colors: null, name: "Finland");
        break;
      case "ru":
        mapInfo = MapModel(instructions: SMapRussia.instructions, colors: null, name: "Russia");
        break;
      case "cn":
        mapInfo = MapModel(instructions: SMapChina.instructions, colors: null, name: "China");
        break;
      case "kr":
        mapInfo = MapModel(instructions: SMapSouthKorea.instructions, colors: null, name: "South Korea");
        break;
      case "jp":
        mapInfo = MapModel(instructions: SMapJapan.instructions, colors: null, name: "Japan");
        break;
      case "in":
        mapInfo = MapModel(instructions: SMapIndia.instructions, colors: null, name: "India");
        break;
      case "za":
        mapInfo = MapModel(instructions: SMapSouthAfrica.instructions, colors: null, name: "South Africa");
        break;
      case "ma":
        mapInfo = MapModel(instructions: SMapMorocco.instructions, colors: null, name: "Morocco");
        break;
      case "br":
        mapInfo = MapModel(instructions: SMapBrazil.instructions, colors: null, name: "Brazil");
        break;
      case "ar":
        mapInfo = MapModel(instructions: SMapArgentina.instructions, colors: null, name: "Argentina");
        break;
      case "pe":
        mapInfo = MapModel(instructions: SMapPeru.instructions, colors: null, name: "Peru");
        break;
      case "mx":
        mapInfo = MapModel(instructions: SMapMexico.instructions, colors: null, name: "Mexico");
        break;
      case "us":
        mapInfo = MapModel(instructions: SMapUnitedStates.instructions, colors: null, name: "United States");
        break;
      case "ca":
        mapInfo = MapModel(instructions: SMapCanada.instructions, colors: null, name: "Canada");
        break;
      default:
        mapInfo = MapModel(
            name: "",
            instructions: SMapWorld.instructionsMercator,
            colors: SMapWorldColors(
              eS : Colors.red,
              pT: Colors.green,
              fR: Colors.blue,
              dE: Colors.yellow,
              iT: Colors.pink,
              gR: Colors.cyan,
              gB: Colors.brown,
              pL: Colors.purple,
              aT: Colors.green,
              aU: Colors.teal,
              nO: Colors.lime,
              sE: Colors.indigo,
              fI: Colors.red,
              rU: Colors.green,
              cN: Colors.red,
              kR: Colors.blue,
              jP: Colors.yellow,
              iN: Colors.pink,
              zA: Colors.cyan,
              mA: Colors.brown,
              bR: Colors.green,
              aR: Colors.blue,
              pE: Colors.yellow,
              mX: Colors.pink,
              uS: Colors.cyan,
              cA: Colors.brown,
            ).toMap()
        );
    }

    return mapInfo;
  }

}