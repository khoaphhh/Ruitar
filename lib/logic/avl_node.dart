
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



  //getter
  int getNodeHeight() {            //node đứng riêng có height = 1
    return height;
  }

  int getNodeBalanceFactor () {
    if (pLeft == null && pRight == null) {
      return 0;
    }
    else if (pLeft == null || pRight == null) {
      return (pLeft == null) ? pRight!.height : -pLeft!.height;
    }
    return pRight!.height - pLeft!.height;  //có thể > 1 và < -1
  }

}
