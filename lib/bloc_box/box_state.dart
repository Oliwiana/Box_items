import 'package:equatable/equatable.dart';

import '../models/BoxItem.dart';

abstract class BoxState extends Equatable{
 const BoxState();

  @override
  List<Object> get props => [];
}

// the state while our application is fetching boxItems from the repository.
class BoxLoadingProgressState extends BoxState {}

// the state of our application after the boxItems have successfully been loaded.
class ListBoxesLoadSuccessState extends BoxState {
  final List<BoxItem> ?boxItems;

   const ListBoxesLoadSuccessState([this.boxItems = const []]);

  @override
  List<Object> get props => [boxItems!];

  @override
  String toString() => 'BoxLoadSuccess { boxItems: $boxItems }';
}

// the state of our application if the boxItems were not successfully loaded.
class BoxLoadFailureState extends BoxState {
  Error? error;

  BoxLoadFailureState({this.error});
}
// class BoxInsertedSucessfully extends BoxState {
//   final String? id;
//
//   BoxInsertedSucessfully({this.id});
//
// }