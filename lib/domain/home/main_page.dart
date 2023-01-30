import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/app/di.dart';
import 'package:flutter_application_1/presantation/login/login_viewmodel.dart';
import 'package:flutter_application_1/presantation/resources/strings_manager.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text(AppStrings.caravanTypes)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    AppStrings.selectCaravanType,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                ),
                FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/json_file/caravan.json"),
                  builder: (context, snapshot) {
                    var dataOku = jsonDecode(snapshot.data.toString());
                    if (snapshot.hasData) {
                      return ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Card(
                              elevation: 20,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular((5))),
                              child: Column(
                                children: [
                                  Image(
                                    image:
                                        NetworkImage(dataOku[index]["image"]),
                                  ),
                                  ListTile(
                                    title: Text(
                                      dataOku[index]["productName"],
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: dataOku.length,
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Failed to load');
                    } else {
                      return const Align(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
