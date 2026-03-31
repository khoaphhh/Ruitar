import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:ruitar/logic/avl_tree.dart';
import 'package:ruitar/logic/avl_node.dart';


void main() {
//test helpers

  bool isBalanced(AVLNode? root) {
    if (root == null) return true;
    int leftHeight = root.pLeft?.getNodeHeight() ?? 0;  //trả về null, thì hãy coi nó là 0
    int rightHeight = root.pRight?.getNodeHeight() ?? 0;
    
    // Chênh lệch không quá 1 VÀ các cây con cũng phải cân bằng
    if ((leftHeight - rightHeight).abs() > 1) return false;
    return isBalanced(root.pLeft) && isBalanced(root.pRight);
  }


  // --- BẮT ĐẦU CÁC KỊCH BẢN TEST (TEST SUITES) ---

  group('AVL Tree - Insert & Rotations', () {
    test('Trường hợp LL (Right Rotation)', () {
      var tree = AVLTree<double, String>();
      // Chèn các số giảm dần sẽ làm cây lệch trái (LL)
      tree.insert(30.0, "A");
      tree.insert(20.0, "B");
      tree.insert(10.0, "C"); // Cú chèn này kích hoạt xoay phải

      // Gốc mới phải là 20.0
      expect(tree.getRoot()?.key, 20.0);
      expect(isBalanced(tree.getRoot()), isTrue);
      expect(tree.getInOrderKeys(), [10.0, 20.0, 30.0]);
    });

    test('Trường hợp LR (Left-Right Rotation)', () {
      var tree = AVLTree<double, String>();
      tree.insert(30.0, "A");
      tree.insert(10.0, "B");
      tree.insert(20.0, "C"); // Cú chèn này kích hoạt xoay kép Trái-Phải

      expect(tree.getRoot()?.key, 20.0);
      expect(isBalanced(tree.getRoot()), isTrue);
      expect(tree.getInOrderKeys(), [10.0, 20.0, 30.0]);
    });
  });

  group('AVL Tree - Removals', () {
    late AVLTree<double, String> tree;

    // setUp chạy trước mỗi testcase trong group này
    setUp(() {
      tree = AVLTree<double, String>();
      // Tạo một cây cân bằng sẵn
      tree.insert(20.0, "Root");
      tree.insert(10.0, "Left");
      tree.insert(30.0, "Right");
      tree.insert(5.0, "LL");
      tree.insert(15.0, "LR");
    });

    test('Xóa nút lá (0 con)', () {
      tree.remove(5.0); // 5.0 là nút lá
      
      expect(tree.getInOrderKeys(), [10.0, 15.0, 20.0, 30.0]);
      expect(isBalanced(tree.getRoot()), isTrue);
    });

    test('Xóa nút có 2 con (Kích hoạt findMin thay thế)', () {
      tree.remove(10.0); // 10.0 có 2 con là 5.0 và 15.0
      
      // Lúc này 15.0 (Min của nhánh phải) sẽ được đôn lên thay 10.0
      expect(tree.getInOrderKeys(), [5.0, 15.0, 20.0, 30.0]);
      expect(isBalanced(tree.getRoot()), isTrue);
    });

    test('Xóa tận gốc (Root Deletion)', () {
      tree.remove(20.0); // Xóa thẳng gốc của cây
      
      expect(tree.getInOrderKeys(), [5.0, 10.0, 15.0, 30.0]);
      expect(isBalanced(tree.getRoot()), isTrue);
      // Gốc mới phải là phần tử nhỏ nhất của nhánh phải (tức là 30.0)
      expect(tree.getRoot()?.key, 10.0); 
    });
  });

  group('AVL Tree - Size & Clear Tests', () {
    late AVLTree<double, String> tree;

    setUp(() {
      tree = AVLTree<double, String>();
    });

    test('Size ban đầu phải bằng 0 và cây phải rỗng', () {
      expect(tree.getSize(), 0);
      expect(tree.isEmpty(), isTrue);
      expect(tree.getRoot(), isNull);
    });

    test('Size tăng chính xác sau nhiều lần chèn liên tiếp', () {
      tree.insert(10.0, "A");
      expect(tree.getSize(), 1);
      
      tree.insert(20.0, "B");
      tree.insert(5.0, "C");
      expect(tree.getSize(), 3);
      expect(tree.isEmpty(), isFalse);
    });

    test('Hàm clear() phải xóa sạch cây và đưa size về 0', () {
      // Chèn dữ liệu
      tree.insert(10.0, "A");
      tree.insert(20.0, "B");
      tree.insert(30.0, "C");
      expect(tree.getSize(), 3);

      // Gọi hàm clear
      tree.clear();

      // Kiểm tra sau khi clear
      expect(tree.getSize(), 0);
      expect(tree.isEmpty(), isTrue);
      expect(tree.getSize(), 0);
      expect(tree.getInOrderKeys(), isEmpty);
    });
  });

  // ---------------------------------------------------------
  // NHÓM TEST MỚI: KIỂM TRA HÀM CONTAINS VÀ SEARCH
  // ---------------------------------------------------------
  group('AVL Tree - Contains Tests', () {
    late AVLTree<double, String> tree;

    setUp(() {
      tree = AVLTree<double, String>();
      // Cây có cấu trúc: 50 làm gốc, 30 bên trái, 70 bên phải
      tree.insert(50.0, "Root");
      tree.insert(30.0, "Left");
      tree.insert(70.0, "Right");
      tree.insert(40.0, "Left-Right");
    });

    test('contains() trả về true cho các key ĐANG TỒN TẠI', () {
      expect(tree.contains(50.0), isTrue);
      expect(tree.contains(30.0), isTrue);
      expect(tree.contains(70.0), isTrue);
      expect(tree.contains(40.0), isTrue);
    });

    test('contains() trả về false cho các key KHÔNG TỒN TẠI', () {
      expect(tree.contains(99.0), isFalse); // Lớn hơn max
      expect(tree.contains(10.0), isFalse); // Nhỏ hơn min
      expect(tree.contains(45.0), isFalse); // Nằm kẹt ở giữa
    });

    test('contains() không bị crash khi tìm trên cây rỗng', () {
      var emptyTree = AVLTree<double, String>();
      expect(emptyTree.contains(10.0), isFalse);
    });
  });

  // ---------------------------------------------------------
  // NHÓM TEST MỚI: TÍNH TOÀN VẸN CỦA DỮ LIỆU & INSERT TRÙNG LẶP
  // ---------------------------------------------------------
  group('AVL Tree - Data Integrity & Duplicates Tests', () {
    late AVLTree<double, String> tree;

    setUp(() {
      tree = AVLTree<double, String>();
    });

    test('getInOrderKeys luôn trả về mảng được sắp xếp tăng dần nghiêm ngặt', () {
      // Chèn dữ liệu lộn xộn để kích hoạt các phép xoay
      List<double> keysToInsert = [50.0, 20.0, 80.0, 10.0, 30.0, 90.0, 40.0];
      for (var k in keysToInsert) {
        tree.insert(k, "Data_$k");
      }

      var inOrderList = tree.getInOrderKeys();
      
      // Mảng in-order mong đợi
      List<double> expectedList = [10.0, 20.0, 30.0, 40.0, 50.0, 80.0, 90.0];
      
      expect(inOrderList, expectedList);
      expect(inOrderList.length, tree.getSize()); // Đảm bảo không mất mát dữ liệu
    });

    test('Insert TRÙNG KEY không làm tăng size và không làm hỏng cấu trúc', () {
      tree.insert(20.0, "Gốc");
      tree.insert(10.0, "Trái");
      expect(tree.getSize(), 2);

      // Cố tình chèn trùng key 20.0
      tree.insert(20.0, "Gốc bị ghi đè");

      // Size vẫn phải là 2
      expect(tree.getSize(), 2);
      
      // Cấu trúc cây (In-order) không được sinh ra nút mới
      expect(tree.getInOrderKeys(), [10.0, 20.0]);
    });
  });
}