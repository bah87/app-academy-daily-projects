import React from 'react';

const TabItem = ({ tab, id, selectedId, updateId }) => {
  if (id === selectedId) {
    return (
      <li>
        <h3 className='selected'>{ tab.title }</h3>
      </li>
    )
  } else {
    return (
      <li onClick={ updateId(id) }>
        <h3 className='tab-title'>{ tab.title }</h3>
      </li>
    )
  }
};

export default TabItem;
