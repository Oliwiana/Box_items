import 'package:equatable/equatable.dart';

import '../models/BoxItem.dart';

abstract class BoxEvent extends Equatable {
  const BoxEvent();
  @override
  List<Object> get props => [];
}

class PullToRefreshEvent extends BoxEvent {}
// tells the bloc that it needs to load the boxItems from the BoxRepository.
class BoxLoadEvent extends BoxEvent {

  @override
  String toString() => 'LoadItems';

}
// tells the bloc that it needs to add a new boxItem to the list of boxItems.
class BoxAdded extends BoxEvent {
  final BoxItem boxItem;
  final String name;


const BoxAdded(this.boxItem, this.name);
  @override
  List<Object> get props => [boxItem];
}
//
//   @override
//   String toString() => 'BoxAdded { boxItem: $boxItem }';
// }
// tells the bloc that it needs to update an existing boxItem.
class BoxUpdated extends BoxEvent {
  final BoxItem boxItem;
  bool complete;
 BoxUpdated(this.boxItem,this.complete);

  @override
  List<Object> get props => [boxItem];
  @override
  String toString() => 'BoxUpdated { boxItem: $boxItem }';
}
// // tells the bloc that it needs to remove an existing boxItem.
class BoxObserve extends BoxEvent {
  // final BoxItem boxItem;
  //
  // const BoxObserve(this.boxItem);
  //
  // @override
  // String toString() => 'BoxDeleted { boxItem: $boxItem }';

}
// // tells the bloc that it needs to remove all completed boxItems.
// class ClearCompleted extends BoxEvent {}
// tells the bloc that it needs to toggle the completed state of all boxItems.
// class ToggleAll extends BoxEvent {}