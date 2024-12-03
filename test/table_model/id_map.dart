import 'package:flutter/material.dart';

mixin IdMap<Type> {
  @protected
  final idMap = <String, Type>{};

  void registerId(String id, Type item) => idMap[id] = item;

  void removeId(String id) => idMap.remove(id);

  Type? getById(String id) => idMap[id];
}