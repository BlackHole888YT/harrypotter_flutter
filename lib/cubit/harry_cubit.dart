import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model.dart';

part 'harry_state.dart';

class HarryCubit extends Cubit<HarryState> {
  HarryCubit() : super(HarryInitial());
  void getHttp() async {
    emit(Loading());

    final dio = Dio();
    final response = await dio.get('https://potterapi-fedeperin.vercel.app/en/characters');
    final List<dynamic> data = response.data;
    final list = data.map((e) => Model.fromJson(e)).toList();
    emit(Success(list));
    //print(response);
  }
}