
enum BalanceValue {LH, EH, RH}


class AVLNode<K, T> {
  K key;
  T data;
  AVLNode<K, T>? pLeft;
  AVLNode<K, T>? pRight;
  BalanceValue balance;
  int height;

  AVLNode(this.key, this.data)  : pLeft = null,
                                  pRight = null,
                                  balance = BalanceValue.EH,
                                  height = 1;

  
}
