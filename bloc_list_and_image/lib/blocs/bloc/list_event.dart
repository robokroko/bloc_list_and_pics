part of 'list_bloc.dart';

abstract class ListItemEvent extends Equatable {
  const ListItemEvent();
}

class SelectItem extends ListItemEvent {
  @override
  List<Object> get props => [];
}

class UnSelectItem extends ListItemEvent {
  @override
  List<Object> get props => [];
}

class FetchImageDetails extends ListItemEvent {
  @override
  List<Object> get props => [];
}
