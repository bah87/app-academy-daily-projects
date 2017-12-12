class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
  }

  bindEvents() {
    $('ul').on('click', 'li', (e) => {
      // debugger
      if (e.target.className === "marked-x" || e.target.className === "marked-o") {
        alert('Invalid move!');
      } else {
        this.makeMove($(e.target));
      }
    });
  }

  makeMove($square) {
    $square.html(`<p>${this.game.currentPlayer.toUpperCase()}</p>`)
      .addClass(`marked-${this.game.currentPlayer}`);
    
    this.game.playMove($square.data().pos);
    
    if (this.game.isOver()) {
      $('ul').off('click');
      const message = `You win, ${this.game.winner().toUpperCase()}!`;
      $('ul').append(message);
      
      $('li').addClass("game-over");
      
      if (this.game.winner() === 'x') {
        $(`li.marked-o`).addClass("loser");
        $(`li.marked-x`).addClass("winner");
      } else {
        $(`li.marked-o`).addClass("winner");
        $(`li.marked-x`).addClass("loser");
      }
    }
  }

  setupBoard() {
    const unorderedList = "<ul id='grid'></ul>";
    this.$el.append(unorderedList);
    for (let i = 0; i < 3; i++) {
      for (let j = 0; j < 3; j++) {
        const li = $('<li></li>').data('pos', [i, j]);
        $('#grid').append(li);
      }
    }
  }
}

module.exports = View;
