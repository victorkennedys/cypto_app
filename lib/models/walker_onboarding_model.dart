import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class WalkerOnboardingModel {
  Future<String?> registerWalker(Map<String, dynamic> dataMap) async {
    final user = _auth.currentUser;
    try {
      final stripeData = await addStripeUser(dataMap, user!);
      final String? stripeAccountId = stripeData['id'];

      if (stripeAccountId != null) {
        await _firestore
            .collection('dog owners')
            .doc(user!.phoneNumber)
            .delete();

        dataMap.addAll({"stripe account id": stripeAccountId});
        print(dataMap);

        _firestore.collection('dog walkers').doc(user.phoneNumber).set(dataMap);
        return stripeAccountId;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future addStripeUser(Map<String, dynamic> dataMap, User user) async {
    String ip =
        await NetworkInfo().getWifiIP() ?? "80.216.210.24"; //remove later.

    String url = 'https://api.stripe.com/v1/accounts';
    Map<String, String> headers = {
      'Authorization': "Bearer $stripeSecretKey",
    };
    Map body = {
      'type': 'custom',
      'country': 'SE',
      'email': dataMap['email'],
      'capabilities[card_payments][requested]': 'true',
      'capabilities[transfers][requested]': 'true',
      'business_type': 'individual',
      'individual[first_name]': dataMap['first name'],
      'individual[last_name]': dataMap['last name'],
      'individual[dob][day]': dataMap['day'].toString(),
      'individual[dob][month]': dataMap['month'].toString(),
      'individual[dob][year]': dataMap['year'].toString(),
      'business_profile[mcc]': '7299',
      'individual[address][city]': dataMap['city'],
      'individual[address][line1]': dataMap['adress'],
      'individual[address][postal_code]': dataMap['post number'],
      'individual[email]': dataMap['email'],
      'individual[phone]': user!.phoneNumber.toString(),
      'tos_acceptance[date]':
          (DateTime.now().millisecondsSinceEpoch / 1000).toInt().toString(),
      'tos_acceptance[ip]': ip,
      /* 'individual[verification][additional_document][front]':
          'https://firebasestorage.googleapis.com/v0/b/woof-ad9a6.appspot.com/o/uploads%2Fimage_picker_6E68A1D8-920F-4AFD-9220-39B81B4DBDBE-812-000006D457BE3ADE.jpg',
      'individual[verification][additional_document][back]':
          'https://firebasestorage.googleapis.com/v0/b/woof-ad9a6.appspot.com/o/uploads%2Fimage_picker_0E07F634-D055-42FE-BC83-42214425153A-812-000006D466A8B3F1.jpg' */
    };
    var data = await http.post(Uri.parse(url), headers: headers, body: body);

    var decodedData = jsonDecode(data.body);
    return decodedData;
  }
}
