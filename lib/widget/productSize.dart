import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSize;
  final Function(String) onSelected;

  const ProductSize({Key key, this.productSize, this.onSelected})
      : super(key: key);
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSize.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected('${widget.productSize[i]}');
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                margin: EdgeInsets.all(4),
                alignment: Alignment.center,
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _selected == i
                      ? Theme.of(context).accentColor
                      : Color(0xFFDCDCDC),
                ),
                child: Text(
                  '${widget.productSize[i]}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: _selected == i ? Colors.white : Colors.black),
                ),
              ),
            )
        ],
      ),
    );
  }
}
