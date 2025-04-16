import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrypotter_flutter/cubit/harry_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HarryCubit()..getHttp();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HarryCubit, HarryState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is Success) {
              final models = state.models;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
                itemBuilder: (context, index) {
                  final item = models[index];
                  return Column(
                    children: [
                      Text(item.fullName!),
                      Image.network(
                        item.image.toString(),
                        width: 200,
                        height: 200,
                        loadingBuilder: (context, widget, event) {
                          if (event == null) return widget;
                          return Center(
                            child: CircularProgressIndicator(
                              value:
                                  event.expectedTotalBytes != null
                                      ? event.cumulativeBytesLoaded /
                                          event.expectedTotalBytes!.toDouble()
                                      : null,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
                itemCount: models.length,
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
