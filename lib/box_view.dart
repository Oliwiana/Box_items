import 'package:box_of_items/bloc_box/box_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_box/box_bloc.dart';
import 'bloc_box/box_state.dart';
import 'loading_view.dart';
import 'models/BoxItem.dart';

class BoxView extends StatefulWidget {
  static const String routeName = "/boxView";
  @override
  State<StatefulWidget> createState() => _BoxViewState();
}

class _BoxViewState extends State<BoxView> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _navBar(),
      floatingActionButton: _floatingActionButton(),
      body: BlocBuilder<BoxBloc, BoxState>(builder: (context, state) {
        if (state is BoxLoadingProgressState) {
          return Center(
            child: LoadingView(),
          );
        } else if (state is ListBoxesLoadSuccessState) {
          return RefreshIndicator(
              onRefresh: () async =>
              BlocProvider.of<BoxBloc>(context)..add(PullToRefreshEvent()),
              child: state.boxItems!.isEmpty
                  ? _emptyTodosView()
                  : _itemsListView(state.boxItems!));
        } else if (state is BoxLoadFailureState) {
          return Center(child: Text('Error: ${state.error}'));
        } else
          return Container();
      }),
    );
  }

  AppBar _navBar() {
    return AppBar(
      title: Text('Items'),
    );
  }

  Widget _newTodoView() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(hintText: 'Enter something!'),
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<BoxBloc>(context)
                  .boxItemsRepository
                  .createItem(_nameController.text);
              _nameController.text = '';
              Navigator.of(context).pop();
            },
            child: Text('Save Item'))
      ],
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('show new sheet');
          showModalBottomSheet(
              context: context, builder: (context) => _newTodoView());
        });
  }

  Widget _emptyTodosView() {
    return Center(
      child: Text('No items yet'),
    );
  }

  Widget _itemsListView(List<BoxItem> boxItems) {
    return ListView.builder(
      itemCount: boxItems.length,
      itemBuilder: (context, index) {
        final boxItem = boxItems[index];
        return Card(
          child: CheckboxListTile(
              title: Text(boxItem.name!),
              value: boxItem.complete,
              onChanged: (newValue) {
                BlocProvider.of<BoxBloc>(context)
                    .boxItemsRepository
                    .updateItemComplete(boxItem, newValue!);
              }),
        );
      },
    );
  }
}
