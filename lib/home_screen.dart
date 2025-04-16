import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/harry_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Персонажи Гарри Поттера')),
      body: BlocBuilder<HarryCubit, HarryState>(
        builder: (context, state) {
          if (state is HarryInitial) {
            context.read<HarryCubit>().fetchCharacters();
            return const Center(child: CircularProgressIndicator());
          }

          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () => context.read<HarryCubit>().fetchCharacters(),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          if (state is Success) {
            final characters = state.models;
            if (characters.isEmpty) {
              return const Center(child: Text('Нет данных для отображения'));
            }

            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              character.image != null
                                  ? Image.network(
                                    character.image!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.person, size: 100),
                                  )
                                  : const Icon(Icons.person, size: 100),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.fullName ?? 'Неизвестный персонаж',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (character.nickname != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  character.nickname!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
