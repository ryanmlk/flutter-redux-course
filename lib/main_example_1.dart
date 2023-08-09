// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart' as hooks;
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'Bloc Course',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     debugShowCheckedModeBanner: false,
//     home: const HomePage(),
//   ));
// }

// enum ItemFilter { all, longTexts, shortTexts }

// @immutable
// class State {
//   final Iterable<String> items;
//   final ItemFilter filter;

//   const State({
//     required this.items,
//     required this.filter,
//   });

//   Iterable<String> get filteredItems {
//     switch (filter) {
//       case ItemFilter.all:
//         return items;
//       case ItemFilter.longTexts:
//         return items.where((e) => e.length >= 10);
//       case ItemFilter.shortTexts:
//         return items.where((e) => e.length <= 3);
//     }
//   }
// }

// @immutable
// abstract class Action {
//   const Action();
// }

// @immutable
// class ChangeFilterTypeAction extends Action {
//   final ItemFilter filter;
//   const ChangeFilterTypeAction(this.filter);
// }

// @immutable
// abstract class ItemAction extends Action {
//   final String item;
//   const ItemAction(this.item);
// }

// @immutable
// class AddItemAction extends ItemAction {
//   const AddItemAction(String item) : super(item);
// }

// @immutable
// class RemoveItemAction extends ItemAction {
//   const RemoveItemAction(String item) : super(item);
// }

// extension AddRemoveItems<T> on Iterable<T> {
//   Iterable<T> operator +(T other) => followedBy([other]);
//   Iterable<T> operator -(T other) => where((element) => element != other);
// }

// Iterable<String> addItemReducer(
//   Iterable<String> previousItems,
//   AddItemAction action,
// ) =>
//     previousItems + action.item;

// Iterable<String> removeItemReducer(
//   Iterable<String> previousItems,
//   RemoveItemAction action,
// ) =>
//     previousItems - action.item;

// ItemFilter itemFilterReducer(
//   State oldState,
//   Action action,
// ) {
//   if (action is ChangeFilterTypeAction) {
//     return action.filter;
//   } else {
//     return oldState.filter;
//   }
// }

// Reducer<Iterable<String>> itemsReducer = combineReducers<Iterable<String>>([
//   TypedReducer<Iterable<String>, AddItemAction>(addItemReducer),
//   TypedReducer<Iterable<String>, RemoveItemAction>(removeItemReducer),
// ]);

// State appStateReducer(State oldState, action) => State(
//       items: itemsReducer(oldState.items, action),
//       filter: itemFilterReducer(oldState, action),
//     );

// class HomePage extends hooks.HookWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final store = Store(
//       appStateReducer,
//       initialState: const State(items: [], filter: ItemFilter.all),
//     );
//     final textController = hooks.useTextEditingController();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: StoreProvider(
//         store: store,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     store
//                         .dispatch(const ChangeFilterTypeAction(ItemFilter.all));
//                   },
//                   child: const Text('All'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     store.dispatch(
//                         const ChangeFilterTypeAction(ItemFilter.shortTexts));
//                   },
//                   child: const Text('Short Items'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     store.dispatch(
//                         const ChangeFilterTypeAction(ItemFilter.longTexts));
//                   },
//                   child: const Text('Long Items'),
//                 ),
//               ],
//             ),
//             TextField(
//               controller: textController,
//               decoration: const InputDecoration(
//                 hintText: 'Item',
//               ),
//             ),
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     store.dispatch(AddItemAction(textController.text));
//                     textController.clear();
//                   },
//                   child: const Text('Add'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     store.dispatch(RemoveItemAction(textController.text));
//                     textController.clear();
//                   },
//                   child: const Text('Remove'),
//                 ),
//               ],
//             ),
//             StoreConnector<State, Iterable<String>>(
//               converter: (store) => store.state.filteredItems,
//               builder: (context, items) {
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: items.length,
//                     itemBuilder: (context, index) {
//                       final item = items.elementAt(index);
//                       return ListTile(title: Text(item));
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
