import 'package:bloc_list_and_image/models/image_raw_data.dart';
import 'package:equatable/equatable.dart';

enum ListItemStatus {
  normal,
  selected,
}

class ListItemState extends Equatable {
  final ImageRawData imageData;
  ListItemStatus? listItemStatus;

  ListItemState({
    required this.imageData,
    required this.listItemStatus,
  });

  ListItemState copyWith({
    bool? isSelected,
    ImageRawData? imageData,
    ListItemStatus? listItemStatus,
  }) {
    return ListItemState(
      imageData: imageData ?? this.imageData,
      listItemStatus: listItemStatus ?? this.listItemStatus,
    );
  }

  factory ListItemState.initial() {
    return ListItemState(listItemStatus: ListItemStatus.normal, imageData: ImageRawData(null, null));
  }

  @override
  List<Object> get props => [imageData];
}
