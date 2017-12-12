class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.render();
    
    $('ul').on('click', (e) => {
      if (this.clicked) {
        let secondClick = $(e.currentTarget).data().tower;
        if (this.clicked === secondClick) {
          alert('INVALID move!');
        } else {
          this.game.move(this.clicked, secondClick);
        }

      } else {
        this.clicked = $(e.currentTarget).data().tower;
      }
    });
    
    
  }
  
  setupTowers() {
    for (let i = 1; i < 4; i++) {
      this.$el.append($('<ul class="tower"></ul>'));
      let ul = $('ul').last();
      ul.data('tower',i);
      for (let j = 1; j < 4; j++) {
        if (i === 1 ){
          ul.append($(`<li class="disc-${j}"></li>`));
        } else {
          ul.append($('<li></li>'));
        }
      }
    }
  }
  
  render() {
    
  }
  
  clickTower() {
    
  }
}

module.exports = View;