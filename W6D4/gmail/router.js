class Router {
  constructor (node) {
    this.node = node;
  }
  
  start () {
    render();
    document.addEventListener("hashchange", render);
  }
  
  activeRoute () {
    
  }
  
  render () {
    this.node.innerHTML = "";
    let currentRoute = this.activeRoute();
  }
}

module.exports = Router;