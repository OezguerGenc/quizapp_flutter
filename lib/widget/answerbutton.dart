import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  final String text;
  bool isSelected;
  final Function onSelect;

  AnswerButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  _AnswerButtonState createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        height: 50,
        child: InkWell(
          onTap: () {
            setState(() {
              widget.onSelect();
              widget.isSelected = false;
              print(widget.isSelected);
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: widget.isSelected ? Colors.yellow : Colors.transparent,
                  border: Border.all(
                    width: 1,
                    color: widget.isSelected ? Colors.black : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: widget.isSelected
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.black,
                        )
                      : null,
                ),
              ),
              SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: widget.isSelected ? Colors.yellow : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
