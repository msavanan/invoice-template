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
  static const String itemLineTotal = "item_line_total";
  static const String itemPrice = "item_price";
  static const String itemQty = "item_quantity";
  static const String itemDiscount = "item_discount";
  static const String amountSubtotal = "amount_subtotal";
  static const String amountTotal = "amount_total";
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
