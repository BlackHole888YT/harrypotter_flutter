import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model.dart';

part 'harry_state.dart';

class HarryCubit extends Cubit<HarryState> {
  final Dio _dio;
  List<Model> _cachedCharacters = [];

  HarryCubit({Dio? dio}) 
      : _dio = dio ?? Dio(),
        super(HarryInitial());

  Future<void> fetchCharacters() async {
    try {
      emit(Loading());
      
      if (_cachedCharacters.isNotEmpty) {
        emit(Success(_cachedCharacters));
        return;
      }

      final response = await _dio.get(
        'https://potterapi-fedeperin.vercel.app/en/characters',
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _cachedCharacters = data.map((e) => Model.fromJson(e)).toList();
        emit(Success(_cachedCharacters));
      } else {
        emit(Error('Ошибка при загрузке данных: ${response.statusCode}'));
      }
    } catch (e) {
      emit(Error('Произошла ошибка: $e'));
    }
  }
}