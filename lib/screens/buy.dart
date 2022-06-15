import 'package:flutter/material.dart';
import 'package:jsdc/util/routes.dart';

class BuyScreen extends StatelessWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: const Image(
              image: AssetImage('assets/images/blue-wallpaper-3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.01),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(MyRoutes.dashboard);
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Color.fromARGB(255, 141, 140, 140),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.4,
                  width: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      'assets/images/logobgr.png',
                    )),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(MyRoutes.dashboard);
                  },
                  child: const Text("BUY"))
            ],
          )
        ],
      ),
    );
  }
}
