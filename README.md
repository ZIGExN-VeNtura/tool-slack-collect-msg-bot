# Slack Collect Message Bot

A Rails application that collects error messages from Slack channels and provides a dashboard for monitoring, tracking, and managing system errors - similar to GCP Error Reporting.

## Purpose

This tool addresses the problem of error messages scattered across Slack channels by:

- **Collecting** error messages from designated Slack channels daily
- **Analyzing** and categorizing similar error types
- **Tracking** occurrence frequency, timestamps, and error patterns
- **Providing** a centralized dashboard for error management
- **Enabling** team collaboration through status management (resolve, mute, acknowledge)

## Features

### 🔍 Error Collection
- Automatically collects error messages from configured Slack channels
- Daily scheduled collection with configurable intervals
- Smart parsing and categorization of error types

### 📊 Dashboard & Analytics
- Visual dashboard showing error occurrence frequency
- Time-based error tracking and trends
- Error grouping by similarity and type
- Statistical insights and reporting

### 🎯 Error Management
- **Resolve**: Mark errors as fixed
- **Mute**: Temporarily silence recurring known errors  
- **Acknowledge**: Confirm awareness of critical errors
- Team collaboration and assignment features

### 📈 Monitoring
- Real-time error frequency monitoring
- Alert system for critical error thresholds
- Historical data and trend analysis
- Export capabilities for reporting

## Technology Stack

- **Backend**: Ruby 3.4.2, Rails 8.0.2.1
- **Database**: MySQL 8.0
- **Frontend**: Hotwire (Turbo + Stimulus)
- **Deployment**: Docker, Kamal
- **CI/CD**: GitHub Actions
- **Code Quality**: RuboCop, Brakeman

## Quick Start

### Using Docker (Recommended for Development)

1. **Initial Setup**:
   ```bash
   ./docker-dev.sh setup
   ```

2. **Start Application**:
   ```bash
   ./docker-dev.sh up
   ```
   
   Access at: http://localhost:3000

3. **Stop Application**:
   ```bash
   ./docker-dev.sh down
   ```

### Available Commands

- `./docker-dev.sh setup` - Initial setup (build, create and migrate database)
- `./docker-dev.sh up` - Start the development environment
- `./docker-dev.sh down` - Stop the development environment
- `./docker-dev.sh logs` - Show web container logs
- `./docker-dev.sh rails <command>` - Run rails commands
- `./docker-dev.sh bash` - Open bash shell in web container
- `./docker-dev.sh test` - Run test suite
- `./docker-dev.sh clean` - Clean up containers and volumes

### Local Development (Without Docker)

1. **Prerequisites**:
   - Ruby 3.4.2
   - MySQL 8.0
   - Node.js

2. **Setup**:
   ```bash
   bundle install
   rails db:create db:migrate
   rails server
   ```

## Configuration

### Environment Variables

- `SLACK_BOT_TOKEN` - Slack bot authentication token
- `SLACK_CHANNELS` - Comma-separated list of channel IDs to monitor
- `DATABASE_URL` - Database connection string
- `COLLECTION_SCHEDULE` - Cron expression for message collection (default: daily)

### Slack Integration

1. Create a Slack app at https://api.slack.com/apps
2. Add bot token scopes: `channels:read`, `channels:history`, `chat:read`
3. Install the app to your workspace
4. Configure the bot token in your environment

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Slack API     │───▶│  Message        │───▶│   Dashboard     │
│   Integration   │    │  Collector      │    │   & Analytics   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │   Error         │
                       │   Categorizer   │
                       └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │   Database      │
                       │   (MySQL)       │
                       └─────────────────┘
```

## Development

### Running Tests

```bash
# Using Docker
./docker-dev.sh test

# Local
rails test
rails test:system
```

### Code Quality

```bash
# Linting
bin/rubocop

# Security scanning
bin/brakeman

# JavaScript dependencies audit
bin/importmap audit
```

### Database

The application uses MySQL 8.0 with the following main entities:

- **Messages**: Raw collected Slack messages
- **ErrorTypes**: Categorized error patterns
- **ErrorOccurrences**: Individual error instances
- **ErrorStatuses**: Management status (resolved, muted, acknowledged)

## Deployment

### Production with Kamal

1. Configure `config/deploy.yml`
2. Deploy:
   ```bash
   kamal setup
   kamal deploy
   ```

### Docker Production

```bash
docker build -t slack-collect-msg .
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<key> slack-collect-msg
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Run tests and ensure code quality checks pass
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## CI/CD

The project uses GitHub Actions for:

- **Security Scanning**: Brakeman for Ruby, importmap audit for JavaScript
- **Code Quality**: RuboCop linting
- **Testing**: Automated test suite with MySQL
- **Deployment**: Automated deployment on successful builds

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For questions, issues, or contributions, please:

1. Check existing [Issues](../../issues)
2. Create a new issue with detailed information
3. Join our development discussions

---

**Note**: This tool is designed to complement, not replace, dedicated error monitoring services. It's particularly useful for teams heavily reliant on Slack for system alerts and error notifications.
