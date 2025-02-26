import 'package:image_picker/image_picker.dart';
import 'package:invoice/constant.dart';

class TemplateType {
  final Map<String, dynamic> layout;
  final Map<String, dynamic> hovered;
  XFile? image;
  String? currency;

  TemplateType(
      {required this.layout,
      required this.hovered,
      required this.currency,
      this.image});

  update(
      {required String key,
      required String value,
      String type = Types.defaults}) {
    if (type == Types.defaults) {
      layout[key] = value;
    } else if (type == Types.itemColumns) {
      layout[LayoutKeys.itemsColumns][key] = value;
    } else if (type == Types.taxes) {
      layout[LayoutKeys.taxes].first[key] =
          double.tryParse((double.tryParse(value) ?? 0).toStringAsFixed(2)) ??
              0;
    }
  }

  updateItem(
      {required String key, required String value, required int rowNum}) {
    final currentRow = layout[LayoutKeys.items][rowNum - 1];
    if ((key == LayoutKeys.itemPrice) ||
        (key == LayoutKeys.itemQty) ||
        (key == LayoutKeys.itemDiscount) ||
        (key == LayoutKeys.itemTax)) {
      String qty = currentRow[LayoutKeys.itemQty].toString();
      String price = currentRow[LayoutKeys.itemPrice].toString();
      String discount = currentRow[LayoutKeys.itemDiscount].toString();

      if (key == LayoutKeys.itemQty) {
        currentRow[key] = int.tryParse(value) ?? 0;
        qty = value;
      } else if (key == LayoutKeys.itemPrice) {
        if (currentRow[LayoutKeys.itemQty].toString().isEmpty) {
          layout[LayoutKeys.items][rowNum - 1][LayoutKeys.itemQty] = 1;
        }
        final priceVal = double.tryParse(value) ?? 0;
        currentRow[key] =
            double.tryParse(priceVal.toStringAsFixed(2) ?? '0') ?? 0;
        price = value;
      } else if (key == LayoutKeys.itemDiscount) {
        currentRow[key] = double.tryParse(value) ?? 0;
        layout[LayoutKeys.items][rowNum - 1][LayoutKeys.itemDiscount] =
            double.tryParse(currentRow[key].toStringAsFixed(2)) ?? 0;
        discount = value;
      } else if (key == LayoutKeys.itemTax) {
        layout[LayoutKeys.items][rowNum - 1][LayoutKeys.itemTax] =
            double.tryParse((double.tryParse(value) ?? 0).toStringAsFixed(2)) ??
                0;
      }

      double priceDouble = (double.tryParse(price) ?? 0);
      double discountPrice = (double.tryParse(discount) ?? 0);

      if (discountPrice > 0.0) {
        discountPrice = priceDouble - ((discountPrice / 100) * priceDouble);
      } else {
        discountPrice = priceDouble;
      }
      final itemLineTotal = discountPrice * (int.tryParse(qty) ?? 1);
      currentRow[LayoutKeys.itemLineTotal] =
          double.tryParse(itemLineTotal.toStringAsFixed(2)) ?? 0;
      layout[LayoutKeys.items][rowNum - 1][LayoutKeys.itemLineTotal] =
          currentRow[LayoutKeys.itemLineTotal];
      _getSubTotal();
      _getTotal();
    } else {
      currentRow[key] = value;
    }
  }

  String getValue(String key, {String type = Types.defaults}) {
    if (key == TotalKeys.amountTotal) {
      return _getTotal();
    } else if (key == TotalKeys.amountSubtotal) {
      return _getSubTotal();
    } else if (type == Types.defaults && layout.containsKey(key)) {
      return layout[key].toString();
    } else if (type == Types.itemColumns) {
      return getItemTitleValue(key);
    } else if (type == Types.taxes) {
      return getTaxValues(key);
    }

    return '';
  }

  String getItemValue({required String key, required int rowNum}) {
    final Map<String, dynamic> item = layout[LayoutKeys.items][rowNum - 1];
    if (item.containsKey(key)) {
      return item[key].toString();
    }

    return '';
  }

  bool getHoveredValue({required String key}) {
    if (hovered.containsKey(key)) {
      return hovered[key];
    }

    return false;
  }

  bool getHoveredItemValue({required String key, required int rowNum}) {
    final Map<String, dynamic> item = hovered[LayoutKeys.items][rowNum - 1];

    if (item.containsKey(key)) {
      return item[key];
    }

    return false;
  }

  updateHoveredItem(
      {required bool isHovered, required String key, required int rowNum}) {
    final Map<String, dynamic> item = hovered[LayoutKeys.items][rowNum - 1];
    item.update(key, (value) => isHovered, ifAbsent: () => isHovered);
  }

  updateHovered({required String key, required bool isHovered}) {
    hovered.update(key, (value) => isHovered, ifAbsent: () => isHovered);
  }

  String getItemTitleValue(key) {
    final Map<String, dynamic> itemsColumns = layout[LayoutKeys.itemsColumns];
    if (itemsColumns.containsKey(key)) {
      return itemsColumns[key];
    }
    return '';
  }

  String getTaxValues(key) {
    final Map<String, dynamic> taxes = layout[LayoutKeys.taxes].first;

    if (taxes.containsKey(key)) {
      if (key == TotalKeys.taxValue) {
        if (taxes[key].runtimeType == String) {
          final tax = double.tryParse(taxes[key]) ?? 0;
          return tax.toStringAsFixed(2);
        }
        return taxes[key].toString();
      }
      return taxes[key].toString();
    }
    return '';
  }

  String _getSubTotal() {
    final List<Map<String, dynamic>> items = layout[LayoutKeys.items];
    double total = 0;
    for (Map<String, dynamic> item in items) {
      if (item[LayoutKeys.itemLineTotal] != '') {
        total += item[LayoutKeys.itemLineTotal];
      }
    }
    layout[LayoutKeys.amountSubtotal] = total;
    return total.toStringAsFixed(2);
  }

  String _getTotal() {
    final double amount = layout[LayoutKeys.amountSubtotal];
    final String taxPercentage = getTaxValues(LayoutKeys.taxPercentage);
    double total = 0;
    double taxValue = 0;
    try {
      //double amountDouble = double.parse(amount);
      double amountDouble = amount;
      taxValue = (double.parse(taxPercentage) * amountDouble / 100);
      total = amountDouble + taxValue;
      layout[LayoutKeys.taxes].first[LayoutKeys.taxValue] = taxValue.toString();
    } catch (e) {
      //print(e);
    }
    layout[LayoutKeys.amountTotal] = total;
    return total.toStringAsFixed(2);
  }

  addRow() {
    final Map<String, Object> row = {
      TableKeys.itemRowNumber: layout[LayoutKeys.items].length + 1,
      TableKeys.itemDescription: '',
      TableKeys.itemQuantity: '',
      TableKeys.itemPrice: '',
      TableKeys.itemDiscount: '',
      TableKeys.itemTax: '',
      TableKeys.itemLineTotal: '',
    };

    final Map<String, bool> rowHovered = {};
    for (String key in row.keys) {
      rowHovered[key] = false;
    }
    layout[LayoutKeys.items].add(row);
    hovered[LayoutKeys.items].add(rowHovered);
  }

  deleteRow(int rowNum) {
    const items = TableKeys.items;
    if (layout[items].length == 1) {
      return;
    }

    layout[items].removeAt(rowNum - 1);
    int index = 1;
    for (Map<String, Object> item in layout[items]) {
      item[TableKeys.itemRowNumber] = index;
      index++;
    }

    //hovered
    hovered[items].removeAt(rowNum - 1);

    _getSubTotal();
    _getTotal();
  }
}

class Template extends TemplateType {
  Template(
      {required super.layout, required super.hovered, required super.currency});
}
