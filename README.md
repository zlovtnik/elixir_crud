# Elixir GraphQL ERP System

A modern ERP system built with Elixir, Phoenix, and SvelteKit, featuring a GraphQL API and PostgreSQL database.

## Project Structure

```
elixir_crud/
├── backend/           # Elixir/Phoenix GraphQL API
│   ├── config/       # Phoenix configuration
│   ├── lib/          # Elixir source code
│   ├── priv/         # Static assets
│   └── test/         # Tests
└── frontend/         # SvelteKit frontend
    ├── src/          # Source code
    │   ├── lib/      # Shared components and utilities
    │   └── routes/   # SvelteKit routes
    └── static/       # Static assets
```

## Features

### Backend
- Elixir/Phoenix GraphQL API
- PostgreSQL database
- Organization and Organization Unit management
- Docker containerization
- Authentication and authorization

### Frontend
- SvelteKit with TypeScript
- GraphQL client with URQL
- Tailwind CSS for styling
- Modern, responsive UI
- Real-time updates

## Prerequisites

- Docker and Docker Compose
- Elixir 1.14+ (for local development)
- Node.js 18+ or Bun
- PostgreSQL (managed via Docker)

## Getting Started

### Backend Setup

1. Start the services using Docker Compose:
```bash
cd backend
docker-compose up -d
```

2. Install dependencies and setup the database:
```bash
mix deps.get
mix ecto.create
mix ecto.migrate
```

3. Start the Phoenix server:
```bash
mix phx.server
```

The GraphQL API will be available at http://localhost:4000/graphiql

### Frontend Setup

1. Install dependencies:
```bash
cd frontend
bun install
```

2. Start the development server:
```bash
bun run dev
```

The frontend will be available at http://localhost:5173

## GraphQL API Documentation

### Queries

1. List Organizations
```graphql
query {
  organizations {
    id
    name
    code
    description
  }
}
```

2. List Organization Units
```graphql
query {
  organizationUnits {
    id
    name
    code
    description
    organization {
      name
    }
  }
}
```

### Mutations

1. Create Organization
```graphql
mutation {
  createOrganization(
    name: "Test Corp"
    code: "TC001"
    description: "Test Corporation"
  ) {
    id
    name
    code
    description
  }
}
```

2. Create Organization Unit
```graphql
mutation {
  createOrganizationUnit(
    name: "Sales Department"
    code: "SALES"
    description: "Sales Department"
    organizationId: "1"
  ) {
    id
    name
    code
    description
    organization {
      name
    }
  }
}
```

## Development

### Backend Development

- Run tests: `mix test`
- Generate documentation: `mix docs`
- Check code style: `mix format`

### Frontend Development

- Run type checking: `bun run check`
- Build for production: `bun run build`
- Preview production build: `bun run preview`

## Environment Variables

### Backend
- `DATABASE_URL`: PostgreSQL connection string
- `PORT`: Server port (default: 4000)
- `SECRET_KEY_BASE`: Phoenix secret key base

### Frontend
- `VITE_GRAPHQL_URL`: GraphQL API URL (default: http://localhost:4000/api/graphql)

## License

MIT 