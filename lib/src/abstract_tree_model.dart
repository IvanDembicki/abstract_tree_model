import 'dart:convert';

// ----------------------------------------------------- //
//             Tree Oriented Programming                 //
//              working with Data Model                  //
//            Abstract Tree Model example                //
// ----------------------------------------------------- //

/// This code demonstrates an abstract tree model.

/// Enum representing the format of tree-related keys in JSON.
enum TreeFormat {
  /// Key representing the type of a node.
  type(key: 'type'),

  /// Key representing the documentation for a node.
  documentation(key: 'doc'),

  /// Key representing the properties of a node.
  properties(key: 'props'),

  /// Key representing the children of a node.
  children(key: 'children');

  /// Constructor for the TreeFormat enum.
  const TreeFormat({required this.key});

  /// The string key associated with this enum value.
  final String key;
}

/// Abstract class representing a tree member.
abstract class ATreeMember {
  /// Returns the root node of the tree.
  AParent get root;

  /// Returns the index of the node in its parent's child list.
  int get index;

  /// Returns the depth of the node in the tree hierarchy.
  int get depth;

  /// Serializes the node to a JSON-compatible map.
  Map<String, dynamic> toJson();

  /// Converts the tree to a human-readable string format.
  String toTree([String tab = '  ']);
}

/// Abstract class representing a parent node with child nodes.
abstract class AParent<Child extends AChild<AParent<Child>>>
    implements ATreeMember {
  /// List of child nodes.
  final List<Child> children = [];

  /// Returns the first child, or null if no children exist.
  Child? get firstChild => _getChildAt(0, children);

  /// Checks if the given child is the first child.
  bool isFirstChild(Child child) => firstChild == child;

  /// Returns the last child, or null if no children exist.
  Child? get lastChild => _getChildAt(children.length - 1, children);

  /// Checks if the given child is the last child.
  bool isLastChild(Child child) => lastChild == child;

  /// Returns the child at the specified index, or null if out of bounds.
  Child? getChildAt(int index) => _getChildAt(index, children);

  /// Returns the previous sibling of the given child, or null if it is the first child.
  Child? previousChild(Child child) {
    if (isFirstChild(child)) return null;
    return children[child.index - 1];
  }

  /// Returns the next sibling of the given child, or null if it is the last child.
  Child? nextChild(Child child) {
    if (isLastChild(child)) return null;
    return children[child.index + 1];
  }

  /// Returns the index of this node. Defaults to 0 if not overridden.
  @override
  int get index => 0;

  /// Returns the depth of this node in the hierarchy. Defaults to 0 if not overridden.
  @override
  int get depth => 0;

  /// Returns the root node. Defaults to itself if not overridden.
  @override
  AParent get root => this;

  int childIndex(Child child) => children.indexOf(child);

  /// Adds a child node.
  void addChild(Child child) => children.add(child);

  /// Removes a child node.
  bool removeChild(Child child) => children.remove(child);

  /// Serializes the node to JSON.
  @override
  Map<String, dynamic> toJson() => _parentToJson(this);

  /// Returns a string representation of the node.
  @override
  String toString() => '$runtimeType';

  /// Converts the tree to a human-readable string format.
  @override
  String toTree([String tab = '  ']) => _toTree(this, tab);
}

/// Abstract class representing a child node with a reference to a parent node.
/// Provides access to parent node, siblings, and utility methods for abstract_tree_model navigation and removal.
abstract class AChild<Parent extends AParent<AChild<Parent>>>
    implements ATreeMember {
  /// Constructor for creating a child node.
  AChild({required this.parent}) {
    parent.addChild(this);
  }

  /// Reference to the parent node.
  final Parent parent;

  /// Returns the root node of the tree.
  @override
  AParent get root => parent.root;

  /// Returns the index of this node in its parent's child list.
  @override
  int get index => parent.childIndex(this);

  /// Sets the index of the node in its parent's child list.
  set index(int value) => _setIndex(value, this, parent.children);

  /// Returns the depth of this node in the tree hierarchy.
  @override
  int get depth => parent.depth + 1;

  /// Returns the first sibling of this node.
  AChild<Parent>? get firstSibling => parent.firstChild;

  /// Returns the last sibling of this node.
  AChild<Parent>? get lastSibling => parent.lastChild;

  /// Returns the previous sibling of this node.
  AChild<Parent>? get prevSibling => parent.children[index - 1];

  /// Returns the next sibling of this node.
  AChild<Parent>? get nextSibling => parent.children[index + 1];

  /// Retrieves the closest ancestor of type [T].
  T? getAncestor<T>() => _getAncestorByInterface<T>(this);

  /// Removes this node from its parent's child list.
  bool remove() => parent.removeChild(this);

  /// Serializes the node to JSON.
  @override
  Map<String, dynamic> toJson() => _childToJson(this);

  @override
  String toString() => '$runtimeType';

  @override
  String toTree([String tab = '  ']) => _toTree(this, tab);
}

/// Abstract class representing a combined node that acts as both a parent and a child.
/// Implements methods for managing children, siblings, and abstract_tree_model traversal.
abstract class ANode<Parent extends AParent<AChild<Parent>>,
        Child extends AChild<AParent<Child>>>
    implements AChild<Parent>, AParent<Child>, ATreeMember {
  ANode({
    required this.parent,
  }) {
    parent.addChild(this);
  }

  @override
  final Parent parent;
  @override
  final List<Child> children = [];

  /// Returns the index of this node within its parent’s child list.
  @override
  int get index => parent.children.indexOf(this);

  @override
  set index(int value) => _setIndex(value, this, parent.children);

  /// Returns the depth of this node in the abstract_tree_model hierarchy.
  @override
  int get depth => parent.depth + 1;

  /// Returns the root node of this abstract_tree_model.
  @override
  AParent get root => parent.root;

  /// Retrieves the closest ancestor of a specified type [T].
  @override
  T? getAncestor<T>() => _getAncestorByInterface<T>(this);

  @override
  Child? get firstChild => getChildAt(0);

  @override
  bool isFirstChild(Child child) => firstChild == child;

  @override
  Child? get lastChild => getChildAt(children.length - 1);

  @override
  bool isLastChild(Child child) => lastChild == child;

  @override
  AChild<Parent>? get firstSibling => parent.firstChild;

  @override
  AChild<Parent>? get lastSibling => parent.lastChild;

  @override
  AChild<Parent>? get prevSibling => parent.getChildAt(index - 1);

  @override
  AChild<Parent>? get nextSibling => parent.getChildAt(index + 1);

  @override
  Child? getChildAt(int index) => _getChildAt(index, children);

  /// Returns the previous child of [child], or null if it is the first child.
  @override
  Child? previousChild(Child child) {
    if (isFirstChild(child)) return null;
    return children[child.index - 1];
  }

  /// Returns the next child of [child], or null if it is the last child.
  @override
  Child? nextChild(Child child) {
    if (isLastChild(child)) return null;
    return children[child.index + 1];
  }

  @override
  int childIndex(Child child) => children.indexOf(child);

  @override
  void addChild(Child child) => children.add(child);

  /// Removes this node from its parent's list of children.
  @override
  bool remove() => parent.removeChild(this);

  @override
  bool removeChild(Child child) => children.remove(child);

  @override
  Map<String, dynamic> toJson() => _parentToJson(this);

  @override
  String toString() => '$runtimeType';

  /// Converts the tree to a human-readable string format.
  @override
  String toTree([String tab = '  ']) => _toTree(this, tab);
}

/// Traverses ancestors of a node to find the first one of a specified type [T].
T? _getAncestorByInterface<T>(AChild current) {
  dynamic holder = current.parent;
  while (holder != null) {
    if (holder is T) return holder;
    if (holder is AChild) {
      holder = holder.parent;
    } else {
      return null;
    }
  }
  return null;
}

/// Retrieves a child at a specific index within a list, returning null if out of bounds.
Child? _getChildAt<Child extends AChild<AParent<dynamic>>>(
  int index,
  List<Child> children,
) {
  if (index < 0 || index >= children.length) return null;
  return children[index];
}

/// Utility function to set the index of a node in its parent's child list.
void _setIndex(
  int index,
  AChild node,
  List<AChild<dynamic>> children,
) {
  children.remove(node);
  children.insert(index, node);
}

/// Serializes a parent type node to JSON format.
Map<String, dynamic> _parentToJson(AParent node) {
  final List<Map<String, dynamic>> childrenMaps = [];
  for (var i = 0; i < node.children.length; i++) {
    final child = node.children[i];
    childrenMaps.add(child.toJson());
  }
  Map<String, dynamic> result = {
    TreeFormat.type.key: '${node.runtimeType}',
    TreeFormat.children.key: childrenMaps,
  };
  return result;
}

/// Serializes a child node to JSON format.
Map<String, dynamic> _childToJson(AChild node) {
  return {TreeFormat.type.key: '${node.runtimeType}'};
}

/// Converts a tree to a human-readable string format.
String _toTree(ATreeMember node, String tab) =>
    JsonEncoder.withIndent(tab).convert(node);
