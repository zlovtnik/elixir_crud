# Elixir CRUD Backend

This is the backend service for the Elixir CRUD application.

## Docker Setup

This project uses Docker for development and deployment. The setup includes:

- A multi-stage Dockerfile for minimal image size and production readiness
- Docker Compose configuration for easy local development
- PostgreSQL database service

### Requirements

- Docker
- Docker Compose

### Quick Start

1. Build and start the services:

```bash
docker compose up -d
```

2. Access the application at http://localhost:4000

### Development Workflow

The Docker setup includes volume mounts for code, dependencies, and build artifacts to enable fast development cycles:

- `.:/app` - Mounts the project code into the container
- `erp-deps:/app/deps` - Persists dependencies between container restarts
- `erp-build:/app/_build` - Persists build artifacts between container restarts

### Database

The PostgreSQL database is accessible:

- From the host at `localhost:5432`
- From other containers at `db:5432`
- Default credentials: `postgres:postgres`

### Environment Variables

The following environment variables can be configured:

- `DATABASE_URL` - PostgreSQL connection string
- `PORT` - The port the application listens on
- `SECRET_KEY_BASE` - Secret key for Phoenix

### Building for Production

To build the production Docker image:

```bash
docker build -t elixir-crud-backend .
```

This creates an optimized, minimal Docker image ready for deployment.
