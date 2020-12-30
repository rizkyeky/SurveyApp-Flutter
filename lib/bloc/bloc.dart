
// import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

part 'bloc_home.dart';
part 'bloc_question.dart';

abstract class Bloc {
  void init();
  void dispose();
}

String formatDate(DateTime date) => DateFormat("d MMMM y").format(date);

