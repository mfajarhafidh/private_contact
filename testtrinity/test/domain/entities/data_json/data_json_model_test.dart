import 'package:flutter_test/flutter_test.dart';
import 'package:testtrinity/domain/entities/data_json/data_json_model.dart';

void main() {
  group('DataJsonModel', () {
    late DataJsonModel dataJsonModel;

    setUp(() {
      dataJsonModel = DataJsonModel();
    });

    test('listDataJson should have 20 items', () {
      expect(dataJsonModel.listDataJson.length, 20);
    });

    test('First item should have correct data', () {
      final firstItem = dataJsonModel.listDataJson.first;
      expect(firstItem['id'], '5c8a80f52dfee238898d64cf');
      expect(firstItem['firstName'], 'Phoebe');
      expect(firstItem['lastName'], 'Monroe');
      expect(firstItem['email'], 'phoebemonroe@furnafix.com');
      expect(firstItem['dob'], '3/2/1982');
    });

    test('Last item should have correct data', () {
      final lastItem = dataJsonModel.listDataJson.last;
      expect(lastItem['id'], '5c8a80f5e3d1f2f2967c4621');
      expect(lastItem['firstName'], 'Paula');
      expect(lastItem['lastName'], 'Turner');
      expect(lastItem['email'], 'paulaturner@furnafix.com');
      expect(lastItem['dob'], '3/2/1982');
    });

    test('Check for null fields in the list', () {
      final itemsWithNullFields = dataJsonModel.listDataJson.where((item) {
        return item['email'] == null || item['dob'] == null;
      }).toList();
      expect(itemsWithNullFields.length, 4);
    });
  });
}
