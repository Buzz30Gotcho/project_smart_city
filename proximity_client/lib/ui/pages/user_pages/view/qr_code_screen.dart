import 'package:flutter/material.dart';

//import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
//import 'package:qrcode_flutter/qrcode_flutter.dart';

class QrCodeScreen extends StatelessWidget {
    const QrCodeScreen({Key? key}) : super(key: key);

  //const QrCodeScreen({Key? key, required this.nom, required this.prenom, required this.numero_product}) : super(key: key);
  //const QrCodeScreen({Key? key}) : super(key: key);
  // final String nom;
  // final String prenom;
  // final String numero_product;


  @override           
  Widget build(BuildContext context) {
    // Récupérer le repository utilisateur à partir du Provider
    //final userRepository = Provider.of<UserRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // // Générer le QR code en utilisant les données de l'utilisateur
            // QrImage(
            //   data: userRepository.userData, // Assurez-vous que cette donnée est valide pour votre cas
            //   version: QrVersions.auto,
            //   size: 200.0,
            // ),
            SizedBox(height: 20),
            Text('Qr Code à montrer au coursier'), // Ajoutez un message informatif
          ],
        ),
      ),
    );
  }
}
