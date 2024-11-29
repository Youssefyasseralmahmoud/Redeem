

import 'package:flutter/material.dart';
import 'package:redeem/theme/colors.dart';



class info_texti_n_auth extends StatefulWidget {
  String?text;
   info_texti_n_auth({
    this.text,
    super.key,
  });

  @override
  State<info_texti_n_auth> createState() => _info_texti_n_auth();
}

class _info_texti_n_auth extends State<info_texti_n_auth> {
  @override
  Widget build(BuildContext context) {
    return Text("${widget.text}",style: TextStyle(color:CustomColors.thirdcolor),);
  }
}