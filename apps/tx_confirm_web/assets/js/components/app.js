import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

import NotFound from '../pages/NotFound';
import NewTransaction from '../pages/transactions/NewTransaction';

const App = props => {
  return (
    <Router>
      <Routes>
          <Route path="/" element={<NewTransaction />}>
          <Route path="*" element={<NotFound />} />
        </Route>
      </Routes>
    </Router>
  )
}

export default App