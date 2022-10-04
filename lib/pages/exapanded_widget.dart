import 'package:flutter/material.dart';
import 'package:parkit/constant.dart';

class ExpandedTextWidget extends StatefulWidget {
  final String text;

  const ExpandedTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandedTextWidget> get createState => _MyWidgetState();
}

class _MyWidgetState extends State<ExpandedTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(201, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.length == ""
            ? Text(widget.text)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flag ? firstHalf : widget.text,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  widget.text.length > 200
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              flag = !flag;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                flag ? "Show more" : "Show less",
                                style: TextStyle(color: primaryColour),
                              ),
                              Icon(
                                flag
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: primaryColour,
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        )
                ],
              ));
  }
}
