import 'dart:convert';

import 'package:assignment_2/Models/pokemonModel.dart';
import 'package:dio/dio.dart';

class Data {
  final dio = Dio();
  Future<List<Pokemon>> getAllPokemon() async {
    final response = await dio.get('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.data);
      final jsonList = data['pokemon'] as List;
      // print(jsonList);
      final pokemons = jsonList.map((e) => Pokemon.fromJson(e)).toList();
      return pokemons;
    }
    return [];
  }



  //
  // static Future<Map<String, dynamic>> getPokemonDetails(String name) async {
  //   final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$name');
  //   return response.data;
  // }
}