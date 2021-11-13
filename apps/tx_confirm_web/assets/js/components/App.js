import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

import NotFound from '../pages/NotFound';
import NewTransaction from '../pages/transactions/NewTransaction';

const App = props => {
  return (
    <Router>
      <Routes>
          <Route path="/" element={<NewTransaction />} exact/>
          <Route path="*" element={<NotFound />} />
      </Routes>
    </Router>
  )
}

export default App