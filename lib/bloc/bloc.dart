
// import 'dart:core';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../locator.dart';
import '../service/service.dart';

part 'bloc_home.dart';
part 'bloc_question.dart';
part 'bloc_list.dart';
part 'bloc_input.dart';

abstract class Bloc {
  void init();
  void dispose();
}

String formatDate(DateTime date) {
  final String formated = DateFormat("d M y").format(date);
  return formated.replaceAll(' ', '-');
}
DateTime convertDate(String date) {
  String str;

  final List<String> dateParse = date.split(' ');

  switch (dateParse[1]) {
    case 'January': dateParse[1] = '01';
      break;
    case 'February': dateParse[1] = '02';
      break;
    case 'March': dateParse[1] = '03';
      break;
    case 'April': dateParse[1] = '04';
      break;
    case 'May': dateParse[1] = '05';
      break;
    case 'June': dateParse[1] = '06';
      break;
    case 'July': dateParse[1] = '07';
      break;
    case 'Agust': dateParse[1] = '08';
      break;
    case 'September': dateParse[1] = '09';
      break;
    case 'October': dateParse[1] = '10';
      break;
    case 'November': dateParse[1] = '11';
      break;
    default: dateParse[1] = '12';
  }

  dateParse[0] = dateParse[0].length == 1 ? '0${dateParse[0]}' : dateParse[0];

  str = '${dateParse[2]}-${dateParse[1]}-${dateParse[0]}';

  return DateTime.parse(str);
}

