class Game {
  constructor() {
    this.towers = [[3, 2, 1], [], []];
    this.movedEverything = false;
    this.moveCount = 0;

    this.readline = require('readline');
    this.reader = this.readline.createInterface({
      input: process.stdin,
      output: process.stdout
    });
  }

  run () {
    while (!this.isWon()) {
      this.promptMove();
    }

    console.log(`You win! It only took you ${this.moveCount} moves.`);
  }

  promptMove() {
    console.log(this.towers);
    this.reader.question(`From Tower: `, (fromTower)=> {
      this.reader.question(`To Tower: `, (toTower)=> {
        if (this.isValidMove(fromTower, toTower)) {
          this.move(fromTower, toTower);
          reader.close();
        }
        else {
          console.log(`Invalid move.`);
          this.promptMove();
        }
      });
    });
  }

  isValidMove(fromTower, toTower) {
    if (fromTower < 0 || fromTower > 2 || fromTower.length === 0) return false;
    else if (toTower < 0 || toTower > 2) return false;
    else if (toTower[toTower.length - 1] < fromTower[fromTower.length - 1]) {
      return false;
    }

    return true;
  }

  move(fromTower, toTower) {
    this.moveCount++;
    this.towers[toTower].push(this.towers[fromTower].pop());
    if (this.towers[0].length === 0) this.movedEverything = true;
  }

  isWon () {
    if (this.movedEverything && (this.towers[0].length === 3 || this.towers[1].length === 3 || this.towers[2].length === 3)) {
      return true;
    }

    return false;
  }
}

const game = new Game ();
game.run();
