import 'package:assignment_2/Models/pokemonModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:assignment_2/Data//data.dart';

class dataProvider extends ChangeNotifier {
  final _service = Data();
  bool isLoading = false;
  List <Pokemon> _pokemons = [];
  List <Pokemon> get pokemons => _pokemons;

  Future <void> getAllPokemons() async {
    isLoading = true;
    notifyListeners();
final response = await _service.getAllPokemon();
// await _service.checkConnectivity();
    _pokemons = response;
    isLoading = false;
    notifyListeners();
  }

}