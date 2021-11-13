import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import '@testing-library/jest-dom';
import userEvent from '@testing-library/user-event';

import NewTransaction from './NewTransaction';
import * as requests from '../../requests';

describe("NewTransaction", () => {
  it("should show result for confirmed block", async () => {
    jest.spyOn(requests, 'checkTransaction').mockImplementation(() => Promise.resolve({ data: { status: 'ok', result: 4 } }))
    render(<NewTransaction />);
    userEvent.type(screen.getByLabelText('Transaction hash'), 'xyz');
    userEvent.click(screen.getByText('Submit'));
    await waitFor(() => {
      expect(screen.getByText('Your transaction is confirmed. (Block height 4)')).toBeInTheDocument();
    });
  });
  it("should show result for unconfirmed block", async () => {
    jest.spyOn(requests, 'checkTransaction').mockImplementation(() => Promise.resolve({ data: { status: 'ok', result: 1 } }))
    render(<NewTransaction />);
    userEvent.type(screen.getByLabelText('Transaction hash'), 'xyz');
    userEvent.click(screen.getByText('Submit'));
    await waitFor(() => {
      expect(screen.getByText('Your transaction is not yet confirmed.')).toBeInTheDocument();
    });
  });
  it("should show result for errors", async () => {
    const error = 'Block miners are on strike'
    jest.spyOn(requests, 'checkTransaction').mockImplementation(() => Promise.resolve({ data: { status: 'error', result: error } }));
    render(<NewTransaction />);
    userEvent.type(screen.getByLabelText('Transaction hash'), 'xyz');
    userEvent.click(screen.getByText('Submit'));
    await waitFor(() => {
      expect(screen.getByText(`There has been an error: ${error}`)).toBeInTheDocument();
    });
  });
});
