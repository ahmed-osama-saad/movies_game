import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormButton extends StatelessWidget {
  final VoidCallback callback;
  final Color buttonColor;
  final String title;
  final String subtitle;

  const FormButton(
      {@required this.callback,
      @required this.buttonColor,
      @required this.title,
      @required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Color(0xfff9f9e2),
      padding: EdgeInsets.all(15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: 5,
        ),
        onPressed: callback,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      subtitle,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: SvgPicture.asset(
                    'assets/playIcon.svg',
                    height: 50,
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
