import React from 'react';

const TxResult = ({ response }) => {
  if (!response) {
    return null;
  }

  if (response.status === 'error') {
    return (
      <div className='alert alert-danger'>There has been an error: {response.result}</div>
    )
  }

  if (response.result < 2) {
    return (
      <div className='alert alert-warning'>Your transaction is not yet confirmed.</div>
    )
  }

  return (
    <div className='alert alert-info'>Your transaction is confirmed. (Block height {response.result})</div>
  )

}

export default TxResult;
