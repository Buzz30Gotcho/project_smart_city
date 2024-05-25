/*import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_dashboard/pages/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
              title: "Dashboard / ${(() {
            switch (_selected) {
              case 0:
                return "Products.";
              case 1:
                return "Stores.";
              default:
                return "Products.";
            }
          }())}"),
          const Divider(height: tiny_50),
          Expanded(
              child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: ListView(
                  children: [
                    const SizedBox(height: normal_200),
                    ListButton(
                        title: "Products",
                        leadIcon: ProximityIcons.product,
                        color: (_selected == 0) ? blueSwatch.shade400 : null,
                        onPressed: () {
                          setState(() {
                            _selected = 0;
                          });
                        }),
                    ListButton(
                        title: "Stores",
                        leadIcon: ProximityIcons.store,
                        color: (_selected == 1) ? greenSwatch.shade300 : null,
                        onPressed: () {
                          setState(() {
                            _selected = 1;
                          });
                        }),
                    ListButton(
                        title: "Orders",
                        leadIcon: ProximityIcons.order,
                        color: (_selected == 2) ? redSwatch.shade400 : null,
                        onPressed: () {
                          setState(() {
                            _selected = 2;
                          });
                        }),
                    ListButton(
                        title: "Users",
                        leadIcon: ProximityIcons.user,
                        color: (_selected == 3) ? yellowSwatch.shade600 : null,
                        onPressed: () {
                          setState(() {
                            _selected = 3;
                          });
                        }),
                    ListButton(
                        title: "Sellers",
                        leadIcon: ProximityIcons.user,
                        color: (_selected == 4) ? yellowSwatch.shade600 : null,
                        onPressed: () {
                          setState(() {
                            _selected = 4;
                          });
                        }),
                  ],
                ),
              ),
              const VerticalDivider(width: tiny_50),
              Expanded(
                  child: (() {
                switch (_selected) {
                  case 0:
                    return const ProductsList();
                  case 1:
                    return const StoresList();
                  default:
                    return const ProductsList();
                }
              }()))
            ],
          )),
        ],
      ),
    );
  }
}

*/
// FREDERIC SAR POUR LE SIMULATEUR ANDROID MISE EN PAGE
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_dashboard/pages/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: (() {
              switch (_selected) {
                case 0:
                  return const ProductsList();
                case 1:
                  return const StoresList();
                default:
                  return const ProductsList();
              }
            }()),
          ),
          Container(
            color: Colors.grey.shade200, // Couleur de fond de la barre de navigation inférieure
            padding: EdgeInsets.symmetric(vertical: 2.0), // Marge intérieure de la barre de navigation inférieure
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavBarItem(
                  title: "Products",
                  icon: ProximityIcons.product,
                  selected: _selected == 0,
                  onPressed: () {
                    setState(() {
                      _selected = 0;
                    });
                  },
                ),
                BottomNavBarItem(
                  title: "Stores",
                  icon: ProximityIcons.store,
                  selected: _selected == 1,
                  onPressed: () {
                    setState(() {
                      _selected = 1;
                    });
                  },
                ),
                BottomNavBarItem(
                  title: "Orders",
                  icon: ProximityIcons.order,
                  selected: _selected == 2,
                  onPressed: () {
                    setState(() {
                      _selected = 2;
                    });
                  },
                ),
                BottomNavBarItem(
                  title: "Users",
                  icon: ProximityIcons.user,
                  selected: _selected == 3,
                  onPressed: () {
                    setState(() {
                      _selected = 3;
                    });
                  },
                ),
                BottomNavBarItem(
                  title: "Sellers",
                  icon: ProximityIcons.user,
                  selected: _selected == 4,
                  onPressed: () {
                    setState(() {
                      _selected = 4;
                    });
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

class BottomNavBarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  const BottomNavBarItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selected ? Colors.blue : Colors.grey, // Couleur de l'icône basée sur l'état de sélection
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: selected ? Colors.blue : Colors.grey, // Couleur du texte basée sur l'état de sélection
            ),
          ),
        ],
      ),
    );
  }
}
