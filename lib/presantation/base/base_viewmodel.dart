import 'dart:async';

import 'package:flutter_application_1/presantation/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _inputStreamController = StreamController<
      FlowState>.broadcast(); // broadcast() birdenfazla kez dinlemeyi sağlar.

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowstate) => flowstate);
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink get inputState; //hangi state de olduğunun öğrenilmesi için
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState; //inputState in çıkışı
}
