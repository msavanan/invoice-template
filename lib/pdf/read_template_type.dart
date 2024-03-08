import 'package:invoice/constant.dart';
import 'package:invoice/template_type.dart';

class ReadTemplate {
  final TemplateType templateType;

  ReadTemplate._instance(this.templateType);

  static ReadTemplate? instance;

  factory ReadTemplate(TemplateType templateType) {
    instance ??= ReadTemplate._instance(templateType);
    return instance!;
  }

  String getValue(String key) {
    return templateType.getValue(key).toString();
  }

  String getTaxValue(String key) {
    return templateType.getTaxValues(key).toString();
  }

  String getItemValue({required key, required int rowNum}) {
    return templateType.getItemValue(key: key, rowNum: rowNum).toString();
  }

  List<Map<String, dynamic>> getItems() {
    return templateType.layout[TableKeys.items];
  }
}
