import React from 'react';
import styled from 'styled-components';

const HeaderContainer = styled.header`
  background-color: ${props => props.theme.colors.secondary};
  color: white;
  padding: 10px 20px;
  text-align: center;
`;

const Header: React.FC = () => {
  return (
    <HeaderContainer>
      <h1>My Custom React App</h1>
    </HeaderContainer>
  );
};

export default Header;
