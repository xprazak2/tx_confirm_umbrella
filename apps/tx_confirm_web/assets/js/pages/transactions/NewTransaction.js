import React, { useState } from 'react';
import axios from 'axios';

const NewTransaction = props => {
  const [txHash, setTxHash] = useState("");
  const [loading, setLoading] = useState(false)

  const onInputChange = event => {
    setTxHash(event.target.value)
  }

  const handleSubmit = event => {
    event.preventDefault()

    const onSuccess = response => {
      console.log(response)
      setLoading(false)
    }

    const onError = response => {
      console.log(response)
      setLoading(false)
    }

    setLoading(true)
    axios.post('api/v1/transactions/check', { params: { 'tx_hash': txHash }}).then(onSuccess).catch(onError)
  }

  return (
    <form>
      <label>
        Transaction hash
        <input type="text" name="tx_hash" onChange={onInputChange} disabled={loading} />
      </label>
        <input type="submit" value="Submit" onClick={handleSubmit} disabled={loading} />
    </form>
  )
}

export default NewTransaction;
