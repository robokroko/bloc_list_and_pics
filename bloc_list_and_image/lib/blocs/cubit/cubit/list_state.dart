part of 'list_cubit.dart';

enum ListStatus { loading, success, failure }

class ListState extends Equatable {
  const ListState._({
    this.status = ListStatus.loading,
    this.items = const <ImageRawData>[],
  });

  final ListStatus status;
  final List<ImageRawData> items;

  const ListState.loading() : this._();

  const ListState.success(List<ImageRawData> items) : this._(status: ListStatus.success, items: items);

  const ListState.failure() : this._(status: ListStatus.failure);

  @override
  List<Object> get props => [];
}
