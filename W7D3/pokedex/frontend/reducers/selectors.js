import lodash from 'lodash';

const selectAllPokemon = (state) => {
  return lodash.values(state.entities.pokemon);
};

export default selectAllPokemon;
