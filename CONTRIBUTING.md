# Contributing to SOC Platform Integrated

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

Be respectful, inclusive, and professional in all interactions.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR-USERNAME/soc-platform-integrated.git`
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Commit with clear messages: `git commit -m "feat: description of changes"`
6. Push to your fork: `git push origin feature/your-feature-name`
7. Open a Pull Request

## Commit Message Guidelines

Follow conventional commits format:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes
- `refactor:` - Code refactoring
- `test:` - Testing changes
- `chore:` - Maintenance changes

Example: `feat: add support for custom Wazuh rules`

## Pull Request Process

1. Update documentation if needed
2. Add tests for new features
3. Ensure all tests pass: `make test`
4. Lint code: `make lint`
5. Keep PR focused on a single feature/fix
6. Provide clear description of changes

## Development Setup

```bash
# Install dependencies
make install

# Run dev environment
docker-compose -f docker-compose.dev.yml up -d

# Run tests
make test

# Run linter
make lint

# Format code
make format
```

## Testing

- Write tests for new features
- Run existing tests before submitting PR
- Aim for >80% code coverage

```bash
make test-coverage
```

## Documentation

- Update README.md for user-facing changes
- Add/update docs in `/docs` directory for complex features
- Include docstrings in code

## Reporting Bugs

- Use GitHub Issues
- Provide reproducible steps
- Include environment details (OS, Docker version, etc.)
- Attach relevant logs

## Feature Requests

- Clearly describe the feature
- Explain the use case
- Suggest implementation approach if possible

## Security Issues

**DO NOT** open public issues for security vulnerabilities. Email `security@example.com` instead.

---

Thank you for contributing!