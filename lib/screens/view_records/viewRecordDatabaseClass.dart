import 'package:cloud_firestore/cloud_firestore.dart';

class ViewRecordDatabase {
  static DateTime now = DateTime.now();
  static DateTime date = DateTime(now.year, now.month, 19);
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Map calculateTotalInReturnList(Map totalReturnItem, List itemsList) {
    // this function  returns a map of total price and qty of return items with key 'price', 'qty' and 'keyList'
    // 'keyList' contains the items name
    for (Map returnItem in itemsList) {
      // print(returnItem['name']);
      // if the return item not exists in total Return item map
      if (totalReturnItem[returnItem['name']] == null) {
        totalReturnItem[returnItem['name']] = {
          'price': returnItem['price'],
          'qty': returnItem['qty']
        };
        List keyList = (totalReturnItem['keyList'] ?? []);
        keyList.add(returnItem['name']);
        totalReturnItem['keyList'] = keyList;
      } else {
        // if the return item already exist increment  the price and quantity to it
        totalReturnItem[returnItem['name']]['price'] += returnItem['price'];
        totalReturnItem[returnItem['name']]['qty'] += returnItem['qty'];
      }
    }
    return totalReturnItem;
  }

  static List convertTotalReturnMapToList(Map totalReturnItemMap) {
    // converting the map of items to list using the key 'keyList' and get values from the map through the key
    List toReturn = [];
    for (String item in totalReturnItemMap['keyList']) {
      print("key : " + item);
      Map itemData = totalReturnItemMap[item];
      toReturn.add(
          {'name': item, 'qty': itemData['qty'], 'price': itemData['price']});
    }
    print(toReturn);
    return toReturn;
  }

  static Map makeDailyStatistics(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDataList) {
    // snapshot.docs.map((e) => e.data()).toList()
    List<Map<String, dynamic>> dataList = []; // individual documents list
    Map totalData = {};
    Map totalReturnItem = {};
    List totalReturnItemList = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> snap in queryDataList) {
      Map<String, dynamic> data = snap.data();
      // checking for the same user doc in total data
      int _index = -1;
      int i = 0;
      for (Map doc in dataList) {
        if (doc['code'] == data['code']) {
          _index = i;
          break;
        }
        i++;
      }
      if (_index != -1) {
        // calculating total return items from two different days orders
        // this function  returns a map of total price and qty of return items with key 'price', 'qty' and 'keyList'
        // 'keyList' contains the items name
        Map totalReturnItemsForOneUser = calculateTotalInReturnList(
            {}, [...dataList[_index]['itemList'], ...data['itemList']]);
        // converting the map of items to list using the key 'keyList' and get values from the map through the key
        // replace the existing itemList with the calculate total of two days itemList
        dataList[_index]['itemList'] =
            convertTotalReturnMapToList(totalReturnItemsForOneUser);
        // amount , returnItemAmount and date  of different days of orders of a user adding in a list
        dataList[_index]['amountReturnItemAmountList'].add({
          'amount': data['amount'],
          'returnItemAmount': data['returnItemAmount'],
          'date': data['date'],
        });
      } else {
        data['amountReturnItemAmountList'] = [
          {
            'amount': data['amount'],
            'returnItemAmount': data['returnItemAmount'],
            'date': data['date'],
          }
        ];
        dataList.add(data);
      }

      totalReturnItem =
          calculateTotalInReturnList(totalReturnItem, data['itemList']);
      var amount = (totalData['amount'] ?? 0) + data['amount'];
      totalData = {'amount': amount};
    }
    // print(totalReturnItem);
    totalData = {...totalData, ...totalReturnItem, 'ordersList': dataList};
    // print(totalData);
    // print(dataList);
    return totalData;
  }

  static Future<Map> getDailyData() async {
    DateTime date = DateTime(now.year, now.month, 19);
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("records/account/records")
          .where('date', isEqualTo: date.toString().substring(0, 10))
          .get();
      return makeDailyStatistics(snapshot.docs);
    } catch (e) {
      print(e.toString());
      throw Exception("failed to save to db check connection");
    }
  }

  static Future<Map> rangeData() async {
    DateTime fdate = DateTime(now.year, now.month, 25);
    DateTime ldate = DateTime(now.year, now.month, 27, 23, 59, 59);
    print(ldate.day);
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("records/account/records")
          .where('dateMs', isGreaterThanOrEqualTo: fdate.millisecondsSinceEpoch)
          .where('dateMs', isLessThanOrEqualTo: ldate.millisecondsSinceEpoch)
          .get();

      print("map");
      print(makeDailyStatistics(snapshot.docs));
      return makeDailyStatistics(snapshot.docs);
    } catch (e) {
      print(e.toString());
      throw Exception("failed to save to db check connection");
    }
  }
}
