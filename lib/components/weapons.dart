class Weapon {
  String name;
  String img;
  int quantity;

  Weapon({this.name, this.img, this.quantity});
}

List<Weapon> weapons = [
  Weapon(name: 'FireBall', img: 'bomb.png' , quantity: 10),
  Weapon(name: 'FuseBall', img: 'bomb.png' , quantity: 10),
  Weapon(name: 'LargeBall', img: 'bomb.png' , quantity: 10),
  Weapon(name: 'VolcanoBomb', img: 'bomb.png' , quantity: 10)
];