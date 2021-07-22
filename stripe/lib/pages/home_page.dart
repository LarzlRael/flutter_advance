import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe/data/tarjetas.dart';
import 'package:stripe/helpers/helpers.dart';
import 'package:stripe/pages/tarjeta_page.dart';
import 'package:stripe/widgets/total_pay_buttom.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('pagar'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Stack(
        children: [
          Positioned(
            height: size.height,
            width: size.width,
            top: 200,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.9,
              ),
              physics: BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, i) {
                final tarjeta = tarjetas[i];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, navegarFadeIn(context, TarjetaPage()));
                  },
                  child: Hero(
                    tag: tarjeta.cardNumber,
                    child: CreditCardWidget(
                      cardNumber: tarjeta.cardNumber,
                      expiryDate: tarjeta.expiracyDate,
                      cardHolderName: tarjeta.cardHolderName,
                      cvvCode: tarjeta.cvv,
                      showBackView: false,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: TotalPayButtom(),
          )
        ],
      ),
    );
  }
}
