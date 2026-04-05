import 'package:flutter/material.dart';

class GuitarStrings extends StatefulWidget  {
  final Function(Map<int, int>) onUpdate; 
  const GuitarStrings({super.key, required this.onUpdate});

  @override
  State<GuitarStrings> createState() {
    return _GuitarStrings();
  } 
}

class _GuitarStrings extends State<GuitarStrings> {
  Map<int, int> activeCells = {};
  
  void triggerUpdate() {
    widget.onUpdate(activeCells);
  }
  

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cellWidth = constraints.maxWidth / 6;//chiều rộng của 1 ô

        return Listener(
          onPointerDown: (event) {      //khi chạm xuống
            int index = (event.localPosition.dx / cellWidth).floor(); //lấy tọa độ x chia cho chiều rộng của 1 ô và làm tròn xuống để ra index của ô

            setState(() {
                activeCells[event.pointer] = index;
            });
            triggerUpdate();
          },
          onPointerMove: (event) {      //khi lướt: nếu lướt trong ô thì không sao, lướt ra ô khác thì mới gọi handleTouch
            int index = (event.localPosition.dx / cellWidth).floor(); //lấy tọa độ x chia cho chiều rộng của 1 ô và làm tròn xuống để ra index của ô

            if (activeCells[event.pointer] != index) {

              setState(() {
                 activeCells[event.pointer] = index;
              });
              triggerUpdate();
            }
          },

          onPointerCancel: (event) {
            setState(() {
              activeCells.remove(event.pointer);
            });
            triggerUpdate();
          },

          onPointerUp: (event) {
            setState(() {
              activeCells.remove(event.pointer);
            });
            triggerUpdate();
          },
          
          child: Row(
            children: List.generate(6, (index) {      //chia 6 phần
              bool isBeingTouched = activeCells.values.contains(index);
              return Expanded(
                
                flex: 1,        //mỗi phần bằng nhau
                child: AnimatedContainer(
                  duration: Duration(milliseconds: (isBeingTouched) ? 0 : 200),       //thêm duration và curve so với Container thông thường
                  curve: Curves.linear, 
                  
                  decoration: BoxDecoration(
                    color: (isBeingTouched) ? Color.fromARGB(0, 0, 0, 0) : const Color.fromARGB(255, 0, 0, 0),
                    border: Border.all(
                      color: Color.fromARGB(100, 255, 255, 255),
                      width: 2.0,
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