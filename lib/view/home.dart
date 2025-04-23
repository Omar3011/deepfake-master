import 'package:deepfake/Controler/HomeBloc/home_cubit.dart';
import 'package:deepfake/constant/color.dart';
import 'package:deepfake/model/DeepModel.dart';
import 'package:deepfake/widgets/CustomFloatButton.dart';
import 'package:deepfake/widgets/text_widget.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/CustomListview.dart';
import '../widgets/custom_text_form_filed.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  List<DeepModel> temp = [];
  TextEditingController search = TextEditingController();
  final GlobalKey<FabCircularMenuPlusState> fabKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<HomeCubit>(context).getData();
    final state = context.read<HomeCubit>().state;
    print(state);
    if (state is HomeDone) {
      temp = state.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatButton(fabKey: fabKey),
      body: Column(
        children: [
          Container(
            //padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
              image: DecorationImage(
                image: AssetImage("assets/images/img.png"),
                fit: BoxFit.fill,
              ),
            ),
            height: MediaQuery.sizeOf(context).height * 1 / 4,
            width: MediaQuery.sizeOf(context).width,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
                color: ColorConst.base.withOpacity(0.4),
              ),

              child: TextWidget(
                text: "Welcome to Hello",
                size: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.sizeOf(context).height * 3 / 4,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormFiled(
                    hintText: "Search your name video",
                    controller: search,
                    validator: (_) {
                      return null;
                    },
                    maxLength: null,
                    onChange: (value) {
                      print("done");
                      final state = context.read<HomeCubit>().state;
                      print(state);
                      if (state is HomeDone) {
                        if (value?.isEmpty ?? true) temp = state.data;
                        print("done");
                        setState(() {
                          temp =
                              state.data
                                  .where(
                                    (element) => element.name
                                        .toLowerCase()
                                        .contains(value!.toLowerCase()),
                                  )
                                  .toList();
                        });
                        print(temp);
                      }
                      return null;
                    },
                  ),
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeDone) {
                      return Expanded(
                        child:
                            temp.isNotEmpty
                                ? CustomListview(data: temp)
                                : TextWidget(
                                  text: "No Videos",
                                  size: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      );
                    } else {
                      return Center(
                        child: TextWidget(
                          text: "Error",
                          size: 18,
                          color: Colors.black,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
