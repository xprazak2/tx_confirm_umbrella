import React, { useState } from 'react';

import TxResult from '../../components/TxResult';
import { checkTransaction } from '../../requests'

const NewTransaction = props => {
  const [txHash, setTxHash] = useState("");
  const [loading, setLoading] = useState(false)
  const [response, setResponse] = useState(null)

  const onInputChange = event => {
    setTxHash(event.target.value);
  }

  const handleSubmit = event => {
    event.preventDefault();
    setResponse(null);

    const onSuccess = response => {
      setLoading(false)
      setResponse(response.data)
    }

    const onError = response => {
      setLoading(false)
    }

    setLoading(true)
    checkTransaction(txHash).then(onSuccess).catch(onError)
  }

  return (
    <React.Fragment>
    <form>
      <label htmlFor="txHash">
        Transaction hash
      </label>
      <input type="text" id="txHash" name="txHash" onChange={onInputChange} disabled={loading} />
      <input type="submit" value="Submit" onClick={handleSubmit} disabled={loading} />
    </form>

    <TxResult response={response} />
    </React.Fragment>
  )
}

export default NewTransaction;
