import 'package:firstcleanarchi/application/advicer/advicer_bloc.dart';
import 'package:firstcleanarchi/presentation/advicer/widgets/advice_field.dart';
import 'package:firstcleanarchi/presentation/advicer/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_btn.dart';

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Advicer'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(
                      child: BlocBuilder<AdvicerBloc, AdvicerState>(
                bloc: BlocProvider.of<AdvicerBloc>(context),
                builder: (context, state) {
                  if (state is AdvicerInitial) {
                    return Text(
                      'Your Advice is waiting for you! :) ',
                    );
                  } else if (state is AdvicerLoading) {
                    return CircularProgressIndicator();
                  } else if (state is AdvicerLoaded) {
                    return AdviceField(advice: state.advice);
                  } else if (state is AdvicerError) {
                    return ErrorMessage(
                      message: state.error,
                    );
                  }
                  return Placeholder();
                },
              ))),
              SizedBox(
                height: 200,
                child: Center(child: CustomButton(
                  onPressed: () {
                    BlocProvider.of<AdvicerBloc>(context)
                        .add(AdviceRequestedEvent());
                  },
                )),
              )
            ],
          ),
        ));
  }
}
