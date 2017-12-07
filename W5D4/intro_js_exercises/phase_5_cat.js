function Cat (name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  console.log(`${this.owner} loves ${this.name}`);
};

Cat.prototype.meow = function () {
  console.log(`${this.name} says \"meow.\"`);
};

const finley = new Cat ("Finley", "Brendan");
const gizmo = new Cat ("Gizmo", "Brian");
const smellyCat = new Cat ("SmellyCat", "No one");

smellyCat.meow = function () {
  console.log(`${this.name} says \"hisssssss.\"`);
};