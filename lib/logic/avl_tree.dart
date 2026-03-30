import 'avl_node.dart';
import 'dart:math';
//import 'dart:collection';         //for using queue

class AVLTree<K extends Comparable<K>, T> {
  int size;   //number of nodes
  AVLNode? root;

  AVLTree () : root = null, size = 0;

  int getHeight(AVLNode? node) {            //node đứng riêng có height = 1
    if (node != null) {return node.height;}
    else {return 0;}
  }

  int getBalanceFactor (AVLNode? node) {
    if (node == null) return 0;
    return getHeight(node.pRight) - getHeight(node.pLeft);  //có thể > 1 và < -1
  }

  void updateNode(AVLNode? node) {    //cập nhật chỉ số của node
    if (node == null) return;
    int hLeft = getHeight(node.pLeft);
    int hRight = getHeight(node.pRight);
    node.height = 1 + max(hLeft, hRight);

    int diff = hRight - hLeft;
    if (diff == 0) {node.balance = BalanceValue.EH;}
    else if (diff > 0) {node.balance = BalanceValue.RH;}
    else {node.balance = BalanceValue.LH;}
  }

  AVLNode rotateRight(AVLNode node) {
      AVLNode temp = node.pLeft!;         //pLeft không null mới xoay phải được
      node.pLeft = temp.pRight;
      temp.pRight = node;

      updateNode(node);
      updateNode(temp);
      return temp;
  }

  AVLNode rotateLeft(AVLNode node) {
      AVLNode temp = node.pRight!;
      node.pRight = temp.pLeft;
      temp.pLeft = node;

      updateNode(node);
      updateNode(temp);
      return temp;
  }

  AVLNode reBalance(AVLNode node) {
    updateNode(node);
    int bf = getBalanceFactor(node);

    if (bf > 1) {   //lệch phải-phải => xoay trái tại node
      if (getBalanceFactor(node.pRight) >= 0) {
        return rotateLeft(node);
      } 
      else {        //lệch phải-trái =>xoay phải tại con phải => trở thành lệch phải phải
        node.pRight = rotateRight(node.pRight!);
        return rotateLeft(node);
      }
    }
    if (bf < -1) {
      if (getBalanceFactor(node.pLeft) <= 0) {
        return rotateRight(node);
      } 
      else { 
        node.pLeft = rotateLeft(node.pLeft!);
        return rotateRight(node);
      }
    }
    updateNode(node);
    return node;
  }

  AVLNode? findMin(AVLNode? node) {       //tìm note có key nhỏ nhất trong cây có roor là 'node'
    if (node == null) return null;
    if (node.pLeft == null) return node;
    while (node != null && node.pLeft != null) {
      node = node.pLeft;
    }
    return node;
  }

  //đường đi: xuất phát từ root và đệ quy đến đúng vị trí sẽ được insert
  //sau khi tới nơi, node vốn dĩ là null sẽ được gán bằng một node mới . sau đó vừa trồi lên vừa gọi reBalance cho những node cha của nó
  AVLNode insertHelper(AVLNode? node, K key, T value) {
    if (node == null) {
      size++;
      return AVLNode(key, value);
    }
    if (key.compareTo(node.key) < 0) { // key < node.key
      node.pLeft = insertHelper(node.pLeft, key, value);
    } 
    else if (key.compareTo(node.key) > 0) { // key > node.key
      node.pRight = insertHelper(node.pRight, key, value);
    } 
    else {
      return node; // Trùng key
    }
    return reBalance(node);         //rebalance sau khi chèn
  }

  void insert(K key, T value) {
    root = insertHelper(root, key, value);
  }

  AVLNode? removeHelper(AVLNode? node, K key) {
  if (node == null) return null;
  if (key.compareTo(node.key) < 0) {  // key < node->key
    node.pLeft = removeHelper(node.pLeft, key);
  }
  else if (key.compareTo(node.key) > 0) {
    node.pRight = removeHelper(node.pRight, key);
  }
  else {//đã thấy key cần xóa

    //trường hợp có 0 con hoặc 1 bên con => gắn con của nó lên làm con của ông
    if (node.pLeft == null) return node.pRight;
    if (node.pRight == null) return node.pLeft;

    //trường hợp 2 con => tìm node con nhỏ nhất bên phải để thay thế
    AVLNode successor = findMin(node.pRight)!;

    node.key = successor.key;               //đang thay thế node cần xóa bằng successor rồi xóa succesor bên cây con phải
    node.data = successor.data;
    node.pRight = removeHelper(node.pRight, successor.key);

  }
  return reBalance(node);
}

  void remove(K key) {
    root = removeHelper(root, key);
  }

  void clearHelper(AVLNode? node) {
    if (node == null) return;
    clearHelper(node.pLeft);
    clearHelper(node.pRight);
    node.pLeft = null;
    node.pRight = null;
  }

  void clear() {
    clearHelper(root);
    root = null;
    size = 0;
  }

  bool contains(K key) {
    AVLNode? cur = root;
    while (cur != null) {
      //if (key<cur->key) cur = cur->pLeft;
      if (key.compareTo(cur.key) < 0) {
        cur = cur.pLeft;
      }
      //else if (key>cur->key) cur = cur->pRight;
      else if (key.compareTo(cur.key) > 0) {
        cur = cur.pRight;
      }
      else {return true;}
    }
    return false;
  }

}