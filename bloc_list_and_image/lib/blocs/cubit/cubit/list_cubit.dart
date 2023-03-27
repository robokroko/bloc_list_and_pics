import 'package:bloc_list_and_image/models/image_raw_data.dart';
import 'package:bloc_list_and_image/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  final Repository repository;

  ListCubit({required this.repository}) : super(const ListState.loading());

  Future<void> fetchImageDataList() async {
    try {
      final items = await repository.fetchImageRawDatas();
      emit(ListState.success(items));
    } on Exception {
      emit(const ListState.failure());
    }
  }
}
