/*
import 'package:abstract_tree_model/abstract_tree_model.dart';

main() {
  runUsageExample();
}

void runUsageExample() {
  final team = Team();
  final group1 = Group(parent: team, num: 1);
  final group2 = Group(parent: team, num: 2);
  //
  User(parent: group1, name: 'John', phone: '342');
  User(parent: group1, name: 'Bill', phone: '147');
  User(parent: group1, name: 'Alex', phone: '675');
  //
  User(parent: group2, name: 'Jerry', phone: '324');
  User(parent: group2, name: 'Steve', phone: '767');
  //
  Group group = team.firstChild as Group;
  User user = group.firstChild as User;
  print(' firstChild: $user');

  user = user.nextSibling as User;
  print('nextSibling: $user');
  user = user.nextSibling as User;
  print('nextSibling: $user');

  group = group.nextSibling as Group;
  user = group.firstChild as User;
  print(' firstChild: $user');
  user = user.nextSibling as User;
  print('nextSibling: $user');

  print('root: ${user.root}');
  print('parent: ${user.parent}');
  print('parent.parent: ${user.parent.parent}');

  print(team.toTree());
}

class Team extends AParent<Group> {}

class Group extends ANode<Team, User> {
  Group({
    required super.parent,
    required this.num,
  });

  final int num;

  @override
  Map<String, dynamic> toJson() {
    final result = super.toJson();
    result['num'] = num;
    return result;
  }
}

class User extends AChild<Group> {
  User({
    required super.parent,
    required this.name,
    required this.phone,
  });

  final String name, phone;

  @override
  String toString() {
    return 'group ${parent.num}: $name $phone';
  }

  @override
  Map<String, dynamic> toJson() {
    final result = super.toJson();
    result['name'] = name;
    result['phone'] = phone;
    return result;
  }
}
// */