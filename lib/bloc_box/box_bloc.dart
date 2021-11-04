import 'package:bloc/bloc.dart';

import '../box_repo.dart';
import 'box_event.dart';
import 'box_state.dart';

class BoxBloc extends Bloc<BoxEvent, BoxState> {
  final boxItemsRepository = BoxRepository();

  BoxBloc() : super(ListBoxesLoadSuccessState());

  @override
  Stream<BoxState> mapEventToState(BoxEvent event) async* {
    if (event is BoxLoadEvent) {
      yield* _mapBoxLoadedToState(event);
    } else if (event is BoxAdded) {
      yield* _mapBoxAddedToState(event);
    } else if (event is BoxUpdated) {
      yield* _mapBoxUpdatedToState(event);
    } else if (event is BoxObserve) {
      yield* _mapBoxObserveState(event);
    }
  }

  Stream<BoxState> _mapBoxLoadedToState(BoxLoadEvent event) async* {
    if (event is BoxLoadEvent || event is PullToRefreshEvent) {
      yield BoxLoadingProgressState();

      try {
        final boxItems = await boxItemsRepository.getItems();
        yield ListBoxesLoadSuccessState(boxItems);
      } on Error catch (e) {
        yield BoxLoadFailureState(error: e);
      } catch (e) {
        print(e);
      }
    }
  }

  Stream<BoxState> _mapBoxAddedToState(BoxAdded event) async* {
    boxItemsRepository.createItem(event.name);
    boxItemsRepository.getItems();
  }

  Stream<BoxState> _mapBoxUpdatedToState(BoxUpdated event) async* {
    boxItemsRepository.updateItemComplete(event.boxItem, event.complete);
    boxItemsRepository.getItems();
  }

  // Stream<BoxState> _mapBoxAddedToState(BoxAdded event) async* {
  //   if (state is ListBoxesLoadSuccessState) {
  //     final List<BoxItem> updatedItem =
  //         List.from((state as ListBoxesLoadSuccessState).boxItems!)
  //           ..add(event.boxItem);
  //     yield ListBoxesLoadSuccessState(updatedItem);
  //     boxItemsRepository.createItem(event.name);
  //     yield ListBoxesLoadSuccessState();
  //     boxItemsRepository.getItems();
  //   }
  // }
  //
  // Stream<BoxState> _mapBoxUpdatedToState(BoxUpdated event) async* {
  //   if (state is ListBoxesLoadSuccessState) {
  //     final List<BoxItem> updatedItem =
  //         (state as ListBoxesLoadSuccessState).boxItems!.map((boxItem) {
  //       return boxItem.id == event.boxItem.id ? event.boxItem : boxItem;
  //     }).toList();
  //     yield ListBoxesLoadSuccessState(updatedItem);
  //     await boxItemsRepository.updateItemComplete(
  //         event.boxItem, event.complete);
  //     yield ListBoxesLoadSuccessState();
  //     boxItemsRepository.getItems();
  //   }
  // }

  Stream<BoxState> _mapBoxObserveState(BoxObserve event) async* {
    final itemSTream = boxItemsRepository.observeItems();
    itemSTream.listen((_) => boxItemsRepository.getItems());
  }
}

// if (state is ListBoxesLoadSuccess) {
//   final updatedItems = (state as ListBoxesLoadSuccess)
//       .boxItems
//       .where((boxItem) => boxItem.id != event.boxItem.id)
//       .toList();
//   yield ListBoxesLoadSuccess(updatedItems);
//   // _saveItems(updatedItems);
// }
//
//   Stream<BoxState> _mapClearCompletedToState() async* {
//     // if (state is ListBoxesLoadSuccess) {
//     //   final List<BoxItem> updatedItems = (state as ListBoxesLoadSuccess)
//     //       .boxItems
//     //       .where((boxItem) => !boxItem.complete!)
//     //       .toList();
//     //   yield ListBoxesLoadSuccess(updatedItems);
//     //   // _saveItems(updatedItems);
//     // }
//   }
//
// // Future _saveItems(List<BoxItem> boxItems) {
// //   return boxItemsRepository.updateItemComplete(boxItems,complete);
// //
// //     // boxItems.map(BoxItem.fromJson(json)).toList(),
// // }
//
