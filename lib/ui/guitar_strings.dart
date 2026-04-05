import 'package:flutter/material.dart';

class GuitarStrings extends StatelessWidget {
  final Function(int) onCellTapped; 
  GuitarStrings({super.key, required this.onCellTapped});



  int currentCellIndex = -1;
  void handleTouch(double dx, double cellWidth) {
    int index = (dx / cellWidth).floor();     //lấy tọa độ x chia cho chiều rộng của 1 ô và làm tròn xuống để ra index của ô

    if (index >= 0 && index <= 5) {     //chỉ 5 index
      if (currentCellIndex != index) {
        currentCellIndex = index;
        print('ô số $index');
        
        // THỰC HIỆN NHIỆM VỤ ĐỘC LẬP CỦA Ô TẠI ĐÂY
        // Ví dụ: Gọi hàm tương ứng, đổi màu ô, phát âm thanh, v.v.
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cellWidth = constraints.maxWidth / 6;//chiều rộng của 1 ô

        return Listener(
          onPointerDown: (event) {      //khi chạm xuống
            handleTouch(event.localPosition.dx, cellWidth);
          },
          // Khi ngón tay lướt (di chuyển) trên màn hình
          onPointerMove: (event) {
            handleTouch(event.localPosition.dx, cellWidth);
          },
          child: Row(
            children: List.generate(6, (index) {      //chia 6 phần
              return Expanded(
                flex: 1,        //mỗi phần bằng nhau
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    border: Border.all(
                      width: 2.0,
                      color: Color.fromARGB(100, 255, 255, 255)
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      const SizedBox(height: 8),
                      Text(
                        'Ô $index',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}