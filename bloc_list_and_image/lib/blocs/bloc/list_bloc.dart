import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_list_and_image/blocs/bloc/list_state.dart';
import 'package:bloc_list_and_image/models/image_raw_data.dart';
import 'package:equatable/equatable.dart';

part 'list_event.dart';

class ListItemBloc extends Bloc<ListItemEvent, ListItemState> {
  ListItemBloc() : super(ListItemState(imageData: ImageRawData('', ''), listItemStatus: ListItemStatus.normal)) {
    on<SelectItem>((SelectItem event, Emitter<ListItemState> emit) {
      emit(
        ListItemState(listItemStatus: ListItemStatus.selected, imageData: state.imageData),
      );
    });

    on<UnSelectItem>((UnSelectItem event, Emitter<ListItemState> emit) {
      emit(
        ListItemState(listItemStatus: ListItemStatus.normal, imageData: state.imageData),
      );
    });

    on<FetchImageDetails>((FetchImageDetails event, Emitter<ListItemState> emit) {
      emit(
        ListItemState(listItemStatus: ListItemStatus.normal, imageData: state.imageData),
      );
    });
  }
}
