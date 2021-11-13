import axios from 'axios';

export const checkTransaction = txHash => axios.post('api/v1/transactions/check', { params: { 'tx_hash': txHash }})
