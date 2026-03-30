import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:ruitar/logic/avl_tree.dart';
import 'package:ruitar/logic/avl_node.dart';


void main() {
int getHeight(AVLNode? node) {
    if (node == null) return 0;
    return 1 + max(getHeight(node.pLeft), getHeight(node.pRight));
  }

  bool isBalanced(AVLNode? node) {
    if (node == null) return true;
    int leftHeight = getHeight(node.pLeft);
    int rightHeight = getHeight(node.pRight);
    
    // Chênh lệch không quá 1 VÀ các cây con cũng phải cân bằng
    if ((leftHeight - rightHeight).abs() > 1) return false;
    return isBalanced(node.pLeft) && isBalanced(node.pRight);
  }

  // 2. Hàm gom dữ liệu duyệt In-order để test tính sắp xếp
  List<double> getInOrderKeys(AVLNode? node) {
    List<double> result = [];
    if (node != null) {
      result.addAll(getInOrderKeys(node.pLeft));
      result.add(node.key);
      result.addAll(getInOrderKeys(node.pRight));
    }
    return result;
  }

  // --- BẮT ĐẦU CÁC KỊCH BẢN TEST (TEST SUITES) ---

  group('AVL Tree - Insert & Rotations', () {
    test('Trường hợp LL (Right Rotation)', () {
      var tree = AVLTree<num, String>();
      // Chèn các số giảm dần sẽ làm cây lệch trái (LL)
      tree.insert(30.0, "A");
      tree.insert(20.0, "B");
      tree.insert(10.0, "C"); // Cú chèn này kích hoạt xoay phải

      // Gốc mới phải là 20.0
      expect(tree.root?.key, 20.0);
      expect(isBalanced(tree.root), isTrue);
      expect(getInOrderKeys(tree.root), [10.0, 20.0, 30.0]);
    });

    test('Trường hợp LR (Left-Right Rotation)', () {
      var tree = AVLTree<num, String>();
      tree.insert(30.0, "A");
      tree.insert(10.0, "B");
      tree.insert(20.0, "C"); // Cú chèn này kích hoạt xoay kép Trái-Phải

      expect(tree.root?.key, 20.0);
      expect(isBalanced(tree.root), isTrue);
      expect(getInOrderKeys(tree.root), [10.0, 20.0, 30.0]);
    });
  });

  group('AVL Tree - Removals', () {
    late AVLTree<num, String> tree;

    // setUp chạy trước mỗi testcase trong group này
    setUp(() {
      tree = AVLTree<num, String>();
      // Tạo một cây cân bằng sẵn
      tree.insert(20.0, "Root");
      tree.insert(10.0, "Left");
      tree.insert(30.0, "Right");
      tree.insert(5.0, "LL");
      tree.insert(15.0, "LR");
    });

    test('Xóa nút lá (0 con)', () {
      tree.remove(5.0); // 5.0 là nút lá
      
      expect(getInOrderKeys(tree.root), [10.0, 15.0, 20.0, 30.0]);
      expect(isBalanced(tree.root), isTrue);
    });

    test('Xóa nút có 2 con (Kích hoạt findMin thay thế)', () {
      tree.remove(10.0); // 10.0 có 2 con là 5.0 và 15.0
      
      // Lúc này 15.0 (Min của nhánh phải) sẽ được đôn lên thay 10.0
      expect(getInOrderKeys(tree.root), [5.0, 15.0, 20.0, 30.0]);
      expect(isBalanced(tree.root), isTrue);
    });

    test('Xóa tận gốc (Root Deletion)', () {
      tree.remove(20.0); // Xóa thẳng gốc của cây
      
      expect(getInOrderKeys(tree.root), [5.0, 10.0, 15.0, 30.0]);
      expect(isBalanced(tree.root), isTrue);
      // Gốc mới phải là phần tử nhỏ nhất của nhánh phải (tức là 30.0)
      expect(tree.root?.key, 10.0); 
    });
  });
}