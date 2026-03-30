import 'avl_node.dart';
import 'avl_helpers.dart';

class AVLTree<K extends Comparable<K>, T> {
  AVLNode? root;

  AVLTree () : root = null;
  void insert(K key, T value) {
    root = insertHelper(root, key, value);
  }

  void remove(K key) {
    root = removeHelper(root, key);
  }
}