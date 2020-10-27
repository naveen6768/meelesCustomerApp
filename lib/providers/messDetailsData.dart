import 'package:flutter/material.dart';
import '../models/messDetails.dart';

// import 'package:provider/provider.dart';
class MessDetailsData extends ChangeNotifier {
  List<MessDetails> _loadedMessDetails = [
    MessDetails(
      messId: 'abcd',
      initialdata: {
        'shop_name': 'Tarang Mess',
        'address': 'Shivam Vihar Colony, Phase-2,Muradnagar,Ghaziabad',
        'Landmark': 'Behind Shanti Hostel',
        'fssai': '25364125630',
        'gst': '985678541254',
        'capacity': '',
        'phone': '',
        'openwholeday': false,
        'monthly': false,
        'lunch_start': '',
        'lunch_end': '',
        'dinner_start': '',
        'dinner_end': '',
      },
      ismonthly: true,
      isopen: false,
    ),
    MessDetails(
      messId: 'abcd',
      initialdata: {
        'shop_name': 'Tarang Mess',
        'address': 'Shivam Vihar Colony, Phase-2,Muradnagar,Ghaziabad',
        'Landmark': 'Behind Shanti Hostel',
        'fssai': '25364125630',
        'gst': '985678541254',
        'capacity': '',
        'phone': '',
        'openwholeday': false,
        'monthly': false,
        'lunch_start': '',
        'lunch_end': '',
        'dinner_start': '',
        'dinner_end': '',
      },
      ismonthly: true,
      isopen: false,
    ),
    MessDetails(
      messId: 'efgh',
      initialdata: {
        'shop_name': 'Sharde Dham Mess',
        'address': 'Shivam Vihar Colony, Phase-2,Muradnagar,Ghaziabad',
        'Landmark': 'Behind Shanti Hostel',
        'fssai': '25687125630',
        'gst': '945235441254',
        'capacity': '',
        'phone': '',
        'openwholeday': false,
        'monthly': false,
        'lunch_start': '',
        'lunch_end': '',
        'dinner_start': '',
        'dinner_end': '',
      },
      ismonthly: true,
      isopen: false,
    ),
    MessDetails(
      messId: 'ijkl',
      initialdata: {
        'shop_name': 'Annpurna Mess',
        'address': 'Shivam Vihar Colony, Phase-2,Muradnagar,Ghaziabad',
        'Landmark': 'Behind Oyo rooms',
        'fssai': '8974566830',
        'gst': '12458441254',
        'capacity': '',
        'phone': '',
        'openwholeday': false,
        'monthly': false,
        'lunch_start': '',
        'lunch_end': '',
        'dinner_start': '',
        'dinner_end': '',
      },
      ismonthly: true,
      isopen: false,
    ),
    MessDetails(
      messId: 'ijkl',
      initialdata: {
        'shop_name': 'Annpurna Mess',
        'address': 'Shivam Vihar Colony, Phase-2,Muradnagar,Ghaziabad',
        'Landmark': 'Behind Oyo rooms',
        'fssai': '8974566830',
        'gst': '12458441254',
        'capacity': '',
        'phone': '',
        'openwholeday': false,
        'monthly': false,
        'lunch_start': '',
        'lunch_end': '',
        'dinner_start': '',
        'dinner_end': '',
      },
      ismonthly: true,
      isopen: false,
    ),
    MessDetails(
      messId: 'ijkl',
      initialdata: {
        'shop_name': 'Annpurna Mess',
        'address': 'Shivam Vihar Colony, Phase-2,Muradnagar,Ghaziabad',
        'Landmark': 'Behind Oyo rooms',
        'fssai': '8974566830',
        'gst': '12458441254',
        'capacity': '',
        'phone': '',
        'openwholeday': false,
        'monthly': false,
        'lunch_start': '',
        'lunch_end': '',
        'dinner_start': '',
        'dinner_end': '',
      },
      ismonthly: true,
      isopen: false,
    ),
  ];

  List<MessDetails> get loadedMessDetails {
    return [..._loadedMessDetails];
  }

  void getMessDetails() {
    notifyListeners();
  }
}
