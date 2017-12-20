import React from 'react';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
    // this.props.requestAllPokemon = this.props.requestAllPokemon.bind(this);
  }

  componentDidMount() {
    // debugger
    this.props.requestAllPokemon();
  }

  render() {
    // debugger
    const pokemon = this.props.pokemon.map( (poke) => {
      return (
        <li key={poke.id}>
          <h2>{poke.name}</h2>
          <img src={poke.image_url}></img>
        </li>
      );
    });

    return (
      <ul>
        {pokemon}
      </ul>
    );
  }
}

export default PokemonIndex;
