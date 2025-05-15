import 'package:flutter/material.dart';

WantedCard(
    {required String personName,
    required String titleOfPost,
    required onClicked}) {
  return GestureDetector(
    onTap: () {
      onClicked();
    },
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xffF2F5F7).withOpacity(.1),
            blurRadius: 10,
          )
        ],
        color: Color(0xffF2F5F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipOval(
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset("assets/img1.png", fit: BoxFit.cover),
              // child: Image.asset(widget.image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            personName,
            style: TextStyle(
                color: Color(0xff424F5C),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            _getSubString(titleOfPost, 12),
            style: TextStyle(
              color: Color(0xff818E9B),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xffFEE8E9),
            ),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //  Text(simpleDoctorModel.rate!),
                    SizedBox(width: 2),

                    SizedBox(width: 4),
                    Text(
                      "مطلوب",
                      style: TextStyle(
                        fontSize: 16,
                        height: 2,
                        color: Color(0xff3D564D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

String _getSubString(String? value, int maxChars) {
  if (value != null) {
    if (value.length < maxChars) {
      return value;
    } else {
      return value.substring(0, maxChars) + '...';
    }
  }
  return 'notSet';
}
