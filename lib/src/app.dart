import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger logger = Logger('MiApp');
ValueNotifier<bool> isDebug = ValueNotifier<bool>(false);
