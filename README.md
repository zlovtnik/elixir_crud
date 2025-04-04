# Elixir GraphQL ERP Server

This is an Elixir-based GraphQL server for an ERP system with PostgreSQL database support.

## Features

- GraphQL API for ERP operations
- PostgreSQL database integration
- Organization management
- Docker containerization
- Phoenix framework

## Prerequisites

- Docker and Docker Compose
- Elixir 1.14+ (for local development)
- PostgreSQL (managed via Docker)

## Getting Started

1. Clone the repository:
```bash
git clone <repository-url>
cd elixir_crud
```

2. Start the services using Docker Compose:
```bash
docker-compose up -d
```

3. The services will be available at:
- GraphQL API: http://localhost:4000/graphiql
- PostgreSQL: localhost:5432

## Development

To run the project locally:

1. Install dependencies:
```bash
mix deps.get
```

2. Create and migrate your database:
```bash
mix ecto.create
mix ecto.migrate
```

3. Start Phoenix server:
```bash
mix phx.server
```

## API Documentation

The GraphQL API documentation is available at `/graphiql` when running the server.

### GraphQL Operations

#### Queries

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

#### Mutations

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

You can test these operations using:
- GraphiQL interface at http://localhost:4000/graphiql
- cURL commands:
```bash
# List organizations
curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "query { organizations { id name code description } }"}' \
  http://localhost:4000/api/graphql

# Create organization
curl -X POST -H "Content-Type: application/json" \
  -d '{"query": "mutation { createOrganization(name: \"Test Corp\", code: \"TC001\", description: \"Test Corporation\") { id name code description } }"}' \
  http://localhost:4000/api/graphql
```

## Database Schema

The system includes two main organization entities:
- Organization
- OrganizationUnit

## Environment Variables

- `DATABASE_URL`: PostgreSQL connection string
- `PORT`: Server port (default: 4000)
- `SECRET_KEY_BASE`: Phoenix secret key base

## License

MIT 