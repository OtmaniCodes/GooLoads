import 'dart:developer' as dev;

class DevLogger{
  static log(String message, {String? name}){
dev.log(message, name: name??"[Unknown]");
  }
}