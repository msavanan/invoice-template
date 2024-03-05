import 'package:invoice/constant.dart';

class TemplateType {
  final Map<String, dynamic> layout;
  final Map<String, dynamic> hovered;

  TemplateType({required this.layout, required this.hovered});

  update(
      {required String key,
      required String value,
      String type = Types.defaults}) {
    if (type == Types.defaults) {
      layout[key] = value;
    } else if (type == Types.itemColumns) {
      layout[LayoutKeys.itemsColumns][key] = value;
    } else if (type == Types.taxes) {
      layout[LayoutKeys.taxes].first[key] = value;
    }
  }

  updateItem(
      {required String key, required String value, required int rowNum}) {
    final currentRow = layout[LayoutKeys.items][rowNum - 1];
    if ((key == LayoutKeys.itemPrice) ||
        (key == LayoutKeys.itemQty) ||
        (key == LayoutKeys.itemDiscount)) {
      String qty = currentRow[LayoutKeys.itemQty].toString();
      String price = currentRow[LayoutKeys.itemPrice].toString();
      String discount = currentRow[LayoutKeys.itemDiscount].toString();

      if (key == LayoutKeys.itemQty) {
        currentRow[LayoutKeys.itemQty] = value;
        qty = value;
      } else if (key == LayoutKeys.itemPrice) {
        currentRow[key] = value;
        price = value;
      } else if (key == LayoutKeys.itemDiscount) {
        currentRow[key] = value;
        discount = value;
      }
      double priceDouble = (double.tryParse(price) ?? 0);
      double discountPrice = (double.tryParse(discount) ?? 0.0);

      if (discountPrice > 0.0) {
        discountPrice = priceDouble - ((discountPrice / 100) * priceDouble);
      } else {
        discountPrice = priceDouble;
      }
      currentRow[LayoutKeys.itemLineTotal] =
          discountPrice * (int.tryParse(qty) ?? 1);
      layout[LayoutKeys.amountSubtotal] = _getSubTotal();
      layout[LayoutKeys.amountTotal] = _getTotal();
    } else {
      currentRow[key] = value;
    }
  }

  String getValue(String key, {String type = Types.defaults}) {
    if (type == Types.defaults && layout.containsKey(key)) {
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
      return taxes[key].toString();
    }
    return '';
  }

  String _getSubTotal() {
    final List<Map<String, dynamic>> items = layout[LayoutKeys.items];
    double total = 0;
    for (Map<String, dynamic> item in items) {
      total += item[LayoutKeys.itemLineTotal];
    }
    layout[LayoutKeys.amountSubtotal] = total;
    return total.toString();
  }

  String _getTotal() {
    final String amount = layout[LayoutKeys.amountSubtotal];
    final String taxValue = getTaxValues(LayoutKeys.taxValue);
    double total = 0;
    try {
      double amountDouble = double.parse(amount);
      total = amountDouble + (double.parse(taxValue) * amountDouble / 100);
    } catch (e) {
      print(e);
    }

    return total.toString();
  }
}

class Template extends TemplateType {
  Template({required super.layout, required super.hovered});
}
