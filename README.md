# Tree Oriented Data Model

by [Ivan Dembicki](https://linkedin.com/in/dembicki)

Working with Data Models in the Tree Oriented Programming paradigm.

## Overview
The classes in this example implement a hierarchical data model within the Tree Oriented Programming paradigm. 
They are designed to represent and manipulate tree structures where each node can act as a parent, a child, or both, depending on its role in the hierarchy.
The paradigm emphasizes clear organization, modularity, and ease of navigation within tree-like data structures.

## Key Concepts:
- **Hierarchy:** Nodes are organized in a strict parent-child relationship, forming a tree.
- **Modularity:** Each node handles its own state and behavior, simplifying maintenance and scalability.
- **Navigation:** Utility methods enable efficient traversal of the tree, including access to parents, children, and siblings.

## Classes:
- **`ATreeMember`:** Base abstraction for all tree members, providing fundamental methods for navigation and serialization.
- **`AParent`:** Represents a node that can have child nodes and provides methods to manage them.
- **`AChild`:** Represents a node with a parent, providing access to ancestors and siblings.
- **`ANode`:** Combines both `AParent` and `AChild`, representing nodes that act as both parents and children.

*This implementation also includes utility functions for serialization and hierarchical navigation, enabling flexible and scalable data modeling.*

## Usage

See also: [Table Model](test)

```dart
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
```

## Additional information

(c) You are free to copy, modify, and distribute this project with attribution 
under the terms of BSD 3-clause license. See the LICENSE file for details.
