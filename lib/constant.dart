class Types {
  static const String defaults = "DEFAULT";
  static const String itemColumns = "ITEM COLUMNS";
  static const String taxes = "TAXES";
}

class LayoutKeys {
  static const String itemsColumns = "items_columns";
  static const String items = "items";
  static const String taxes = "taxes";
  static const String taxValue = "tax_value";
  static const String taxPercentage = "tax_percentage";
  static const String itemLineTotal = "item_line_total";
  static const String itemPrice = "item_price";
  static const String itemQty = "item_quantity";
  static const String itemDiscount = "item_discount";
  static const String amountSubtotal = "amount_subtotal";
  static const String amountTotal = "amount_total";
  static const String companyLogo = "company_logo";
}

class HeaderKeys {
  static const String logo = "company_logo";
  static const String companyName = "company_name";
  static const String companyInfo1 = "company_info1";
  static const String companyInfo2 = "company_info2";
  static const String companyInfo3 = "company_info3";
  static const String companyInfo4 = "company_info4";
  static const String companyInfo5 = "company_info5";
  static const String companyInfo6 = "company_info6";
  static const String companyInfo7 = "company_info7";
  static const String companyInfo8 = "company_info8";

  static List<String> get leftList {
    return [
      companyName,
      companyInfo1,
      companyInfo2,
      companyInfo3,
      companyInfo4
    ];
  }

  static List<String> get rightList {
    return [companyInfo5, companyInfo6, companyInfo7, companyInfo8];
  }
}

class BillingKeys {
  static const String billLabel = "bill_to_label";
  static const String billInfo1 = "bill_to_info1";
  static const String billInfo2 = "bill_to_info2";
  static const String billInfo3 = "bill_to_info3";
  static const String billInfo4 = "bill_to_info4";
  static const String billInfo5 = "bill_to_info5";

  //Right
  static const String invoiceNumLabel = "invoice_number_label";
  static const String invoiceDateLabel = "invoice_date_label";
  static const String issueDateLabel = "issue_date_label";
  static const String dueDateLabel = "due_date_label";

  static const String invoiceNumber = "invoice_number";
  static const String invoiceDate = "invoice_date";
  static const String issueDate = "issue_date";
  static const String dueDate = "due_date";

  static List<String> get leftList => [
        billLabel,
        billInfo1,
        billInfo2,
        billInfo3,
        billInfo4,
        billInfo5,
      ];

  static List<String> get rightListOne =>
      [invoiceNumLabel, invoiceDateLabel, issueDateLabel, dueDateLabel];
  static List<String> get rightListTwo =>
      [invoiceNumber, invoiceDate, issueDate, dueDate];
}

class TotalKeys {
  static const String amountSubtotalLabel = 'amount_subtotal_label';
  static const String amountSubtotal = "amount_subtotal";
  static const String amountTotalLabel = "amount_total_label";
  static const String amountTotal = "amount_total";

  static const String taxName = "tax_name";
  static const String taxValue = "tax_value";
}

class TermsKeys {
  static const String termsLabel = 'terms_label';
  static const String terms = 'terms';
}

class TableKeys {
  static const String invoiceTitle = 'invoice_title';
  static const String items = 'items';

  static const String itemRowNumberLabel = "item_row_number_label";
  static const String itemDescriptionLabel = "item_description_label";
  static const String itemQuantityLabel = "item_quantity_label";
  static const String itemPriceLabel = "item_price_label";
  static const String itemDiscountLabel = "item_discount_label";
  static const String itemTaxLabel = "item_tax_label";
  static const String itemAmountLabel = "item_amount_label";

  static const String itemRowNumber = "item_row_number";
  static const String itemDescription = "item_description";
  static const String itemQuantity = "item_quantity";
  static const String itemPrice = "item_price";
  static const String itemDiscount = "item_discount";
  static const String itemTax = "item_tax";
  static const String itemLineTotal = "item_line_total";

  static const List<String> title = [
    itemRowNumberLabel,
    itemDescriptionLabel,
    itemQuantityLabel,
    itemPriceLabel,
    itemDiscountLabel,
    itemTaxLabel,
    itemAmountLabel
  ];

  static const List<String> itemsList = [
    itemRowNumber,
    itemDescription,
    itemQuantity,
    itemPrice,
    itemDiscount,
    itemTax,
    itemLineTotal
  ];
}

class Paper {
  static const double width = 720;
  static const double height = 1028;
}
