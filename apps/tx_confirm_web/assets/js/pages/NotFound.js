import React from 'react'
import { Link } from 'react-router-dom';

const NotFound = props => {
  return (
    <div className='container'>
      <div className='phx-hero'>The page you are looking for does not exist. Go to <Link to='/'>main page</Link></div>
    </div>
  )
}

export default NotFound;
