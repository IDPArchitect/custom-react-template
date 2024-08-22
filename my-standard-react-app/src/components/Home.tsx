import React, { useState, useEffect } from 'react';
import styled from 'styled-components';

const HomeContainer = styled.div`
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
`;

const Title = styled.h1`
  color: ${props => props.theme.colors.primary};
`;

const Paragraph = styled.p`
  margin-bottom: 20px;
`;

interface Post {
  id: string;
  title: string;
  author: string;
}

const Home: React.FC = () => {
  const [posts, setPosts] = useState<Post[]>([]);

  useEffect(() => {
    fetch('http://localhost:3001/posts')
      .then(response => response.json())
      .then(data => setPosts(data));
  }, []);

  return (
    <HomeContainer>
      <Title>Welcome to Our Custom React Template</Title>
      <Paragraph>
        This template is set up with React, TypeScript, and styled-components.
        It's ready for you to start building your application!
      </Paragraph>
      <Paragraph>
        Some features included in this template:
      </Paragraph>
      <ul>
        <li>React with TypeScript</li>
        <li>Routing with react-router-dom</li>
        <li>Styling with styled-components</li>
        <li>Linting with ESLint</li>
        <li>Code formatting with Prettier</li>
        <li>Mock API with json-server</li>
      </ul>
      <h2>Posts from JSON Server:</h2>
      <ul>
        {posts.map(post => (
          <li key={post.id}>{post.title} by {post.author}</li>
        ))}
      </ul>
    </HomeContainer>
  );
};

export default Home;
