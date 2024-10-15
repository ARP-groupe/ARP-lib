import 'package:arp_lib/src/data/models/v1.0.0/dto/settings.dart';
import 'package:rxdart/rxdart.dart';



Settings defaultSettings = Settings(    darkTheme: false,
    language: 'en_US',);

final BehaviorSubject<Settings> settings = BehaviorSubject<Settings>()
  ..sink.add(defaultSettings);