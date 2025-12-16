import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

extension PagingControllerX<B, T> on PagingController<B, T> {
  void removeItem(T item) {
    final index = itemList!.indexOf(item);
    if (index != -1) {
      itemList!.removeAt(index);
    }
    value = PagingState<B, T>(
      itemList: itemList?.isEmpty ?? true ? [] : itemList,
      error: null,
      nextPageKey: nextPageKey != firstPageKey ? nextPageKey : null,
    );
  }

  void removeItemWhere(bool Function(T element) test) {
    itemList!.removeWhere((element) => test(element));
    value = PagingState<B, T>(
      itemList: itemList?.isEmpty ?? true ? [] : List.from(itemList!),
      error: null,
      nextPageKey: nextPageKey != firstPageKey ? nextPageKey : null,
    );
  }

  void addItem(T item) {
    if (value.itemList != null) {
      final previousItems = value.itemList ?? [];
      final itemList = [item] + previousItems;

      value = PagingState<B, T>(
          itemList: itemList,
          error: null,
          nextPageKey: nextPageKey != firstPageKey ? nextPageKey : null);
    }
  }

  void upadteItem(T item, T itemupdated) {
    final index = itemList!.indexOf(item);
    if (index != -1) {
      itemList!.removeAt(index);
    }
    itemList!.insert(index, itemupdated);

    value = PagingState<B, T>(
        itemList: itemList,
        error: null,
        nextPageKey: nextPageKey != firstPageKey ? nextPageKey : null);
  }
}
