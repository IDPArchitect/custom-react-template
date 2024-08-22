import React from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import styled from 'styled-components';
import Home from './components/Home';
import Header from './components/Header';

const Navigation = styled.nav`
  background-color: ${props => props.theme.colors.primary};
  padding: 10px;
`;

const NavLink = styled(Link)`
  color: white;
  text-decoration: none;
  margin-right: 10px;
  &:hover {
    text-decoration: underline;
  }
`;

const About = () => <div>About Page</div>;

const App: React.FC = () => {
  return (
    <Router>
      <Header />
      <Navigation>
        <NavLink to="/">Home</NavLink>
        <NavLink to="/about">About</NavLink>
      </Navigation>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
      </Routes>
    </Router>
  );
};

export default App;
