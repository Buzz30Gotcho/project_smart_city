import 'package:flutter/material.dart';
import 'package:proximity_client/ui/pages/main_pages/widgets/single_select.dart';

/// Contains common actions that are used by different Single select classes.
class SingleSelectActions<T> {
  T? onItemCheckedChange(T? selectedValue, T itemValue, bool checked) {
    return checked ? itemValue : null;
  }

  /// Pops the dialog from the navigation stack and returns the initially selected value.
  void onCancelTap(BuildContext ctx, T? initialValue) {
    Navigator.pop(ctx, initialValue);
  }

  /// Pops the dialog from the navigation stack and returns the selected value.
  /// Calls the onConfirm function if one was provided.
  void onConfirmTap(
      BuildContext ctx, T? selectedValue, Function(T?)? onConfirm) {
    Navigator.pop(ctx, selectedValue);
    if (onConfirm != null) {
      onConfirm(selectedValue);
    }
  }

  /// Accepts the search query, and the original list of items.
  /// If the search query is valid, return a filtered list, otherwise return the original list.
  List<SingleSelectItem<T>> updateSearchQuery(
      String? val, List<SingleSelectItem<T>> allItems) {
    if (val != null && val.trim().isNotEmpty) {
      List<SingleSelectItem<T>> filteredItems = [];
      for (var item in allItems) {
        if (item.label.toLowerCase().contains(val.toLowerCase())) {
          filteredItems.add(item);
        }
      }
      return filteredItems;
    } else {
      return allItems;
    }
  }

  /// Toggles the search field.
  bool onSearchTap(bool showSearch) {
    return !showSearch;
  }

  List<SingleSelectItem<T>> separateSelected(List<SingleSelectItem<T>> list) {
    List<SingleSelectItem<T>> selectedItems = [];
    List<SingleSelectItem<T>> nonSelectedItems = [];

    nonSelectedItems.addAll(list.where((element) => !element.selected));
    nonSelectedItems.sort((a, b) => a.label.compareTo(b.label));
    selectedItems.addAll(list.where((element) => element.selected));
    selectedItems.sort((a, b) => a.label.compareTo(b.label));

    return [...selectedItems, ...nonSelectedItems];
  }
}

/// Represents an item in the SingleSelectDialog.
/*class SingleSelectItem<T> {
  final T value;
  final String label;
  bool selected;

  SingleSelectItem(
      {required this.value, required this.label, this.selected = false});
}*/

/// A dialog containing a list of items to select from.
class SingleSelectDialog<T> extends StatefulWidget with SingleSelectActions<T> {
  /// List of items to select from.
  final List<SingleSelectItem<T>> items;

  /// The currently selected value.
  final T? initialValue;

  /// The text at the top of the dialog.
  final Widget? title;

  /// Fires when an item is selected.
  final void Function(T)? onSelected;

  /// Fires when confirm is tapped.
  final void Function(T?)? onConfirm;

  /// Toggles search functionality. Default is false.
  final bool searchable;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Sets a fixed height on the dialog.
  final double? height;

  /// Sets a fixed width on the dialog.
  final double? width;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color? Function(T)? colorator;

  /// The background color of the dialog.
  final Color? backgroundColor;

  /// The color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Icon button that shows the search field.
  final Icon? searchIcon;

  /// Icon button that hides the search field
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Moves the selected items to the top of the list.
  final bool separateSelectedItems;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  SingleSelectDialog({Key? key, 
    required this.items,
    this.initialValue,
    this.title,
    this.onSelected,
    this.onConfirm,
    this.searchable = false,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.searchHint,
    this.height,
    this.width,
    this.colorator,
    this.backgroundColor,
    this.unselectedColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchHintStyle,
    this.searchTextStyle,
    this.selectedItemsTextStyle,
    this.separateSelectedItems = false,
    this.checkColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleSelectDialogState<T>(items);
}

class _SingleSelectDialogState<T> extends State<SingleSelectDialog<T>> {
  T? _selectedValue;
  bool _showSearch = false;
  List<SingleSelectItem<T>> _items;

  _SingleSelectDialogState(this._items);

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;

    for (int i = 0; i < _items.length; i++) {
      _items[i].selected = _selectedValue == _items[i].value;
    }

    if (widget.separateSelectedItems) {
      _items = widget.separateSelected(_items);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(SingleSelectItem<T> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
      ),
      child: RadioListTile<T>(
        value: item.value,
        groupValue: _selectedValue,
        activeColor: widget.colorator != null
            ? widget.colorator!(item.value) ?? widget.selectedColor
            : widget.selectedColor,
        title: Text(
          item.label,
          style: item.selected
              ? widget.selectedItemsTextStyle
              : widget.itemsTextStyle,
        ),
        onChanged: (selectedValue) {
          setState(() {
            _selectedValue =
                widget.onItemCheckedChange(_selectedValue, item.value, true);

            item.selected = true;

            if (widget.separateSelectedItems) {
              _items = widget.separateSelected(_items);
            }
          });
          if (widget.onSelected != null) {
            widget.onSelected!(_selectedValue as T);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.backgroundColor,
      title: widget.searchable == false
          ? widget.title ?? const Text("Select Category")
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _showSearch
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: widget.searchTextStyle,
                            decoration: InputDecoration(
                              hintStyle: widget.searchHintStyle,
                              hintText: widget.searchHint ?? "Search",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: widget.selectedColor ??
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              List<SingleSelectItem<T>> filteredList = [];
                              filteredList =
                                  widget.updateSearchQuery(val, widget.items);
                              setState(() {
                                if (widget.separateSelectedItems) {
                                  _items =
                                      widget.separateSelected(filteredList);
                                } else {
                                  _items = filteredList;
                                }
                              });
                            },
                          ),
                        ),
                      )
                    : widget.title ?? const Text("Search category"),
                IconButton(
                  icon: _showSearch
                      ? widget.closeSearchIcon ?? const Icon(Icons.close)
                      : widget.searchIcon ?? const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _showSearch = !_showSearch;
                      if (!_showSearch) {
                        if (widget.separateSelectedItems) {
                          _items = widget.separateSelected(widget.items);
                        } else {
                          _items = widget.items;
                        }
                      }
                    });
                  },
                ),
              ],
            ),
      contentPadding: const EdgeInsets.all(20),
      content: SizedBox(
          height: widget.height,
          width: widget.width ?? MediaQuery.of(context).size.width * 0.73,
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _buildListItem(_items[index]);
            },
          )),
      actions: <Widget>[
        TextButton(
          child: widget.cancelText ??
              Text(
                "CANCEL",
                style: TextStyle(
                  color: (widget.selectedColor != null &&
                          widget.selectedColor != Colors.transparent)
                      ? widget.selectedColor!.withOpacity(1)
                      : Theme.of(context).primaryColor,
                ),
              ),
          onPressed: () {
            widget.onCancelTap(context, widget.initialValue);
          },
        ),
        TextButton(
          child: widget.confirmText ??
              Text(
                'OK',
                style: TextStyle(
                  color: (widget.selectedColor != null &&
                          widget.selectedColor != Colors.transparent)
                      ? widget.selectedColor!.withOpacity(1)
                      : Theme.of(context).primaryColor,
                ),
              ),
          onPressed: () {
            widget.onConfirmTap(context, _selectedValue, widget.onConfirm);
          },
        )
      ],
    );
  }
}
