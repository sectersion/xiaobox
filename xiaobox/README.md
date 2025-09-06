# XIAOBOX - Unblocked Games & Development Environment

XIAOBOX is a comprehensive Docker-based platform providing unblocked access to games and development tools for educational environments.

## 🚀 Quick Start

### Linux/macOS:
1. **Configure your setup** in `config.yml`
2. **Generate Docker Compose** with `./generate-compose.sh`
3. **Start services** with `./start.sh`

### Windows:
1. **Configure your setup** in `config.yml`
2. **Generate Docker Compose** with `generate-compose.bat`
3. **Start services** with `start.bat`

## 📋 Configuration System

XIAOBOX uses a centralized configuration file (`config.yml`) to control all aspects of your deployment.

### Available Services

| Service | Description | Default Port |
|---------|-------------|--------------|
| nginx | Main web server | 80 |
| traefik | Reverse proxy | 8080 (dashboard) |
| thelounge | IRC client | 9000 |
| minecraft | Minecraft server | 25565 |
| bungeecord | Minecraft proxy | 25577 |
| code-server | VS Code in browser | 8082 |

### Configuration Options

#### Enable/Disable Services
```yaml
services:
  nginx: true
  traefik: true
  thelounge: true
  minecraft: true
  bungeecord: true
  code_server: true
```

#### Port Configuration
```yaml
ports:
  nginx: 80
  traefik_dashboard: 8080
  thelounge: 9000
  code_server: 8082
  minecraft: 25565
```

#### Minecraft Settings
```yaml
minecraft:
  version: "1.12"
  motd: "XIAOBOX Minecraft Server"
  online_mode: false
```

## 🛠️ Usage

### 1. Edit Configuration
```bash
# Edit config.yml to customize your setup
nano config.yml
```

### 2. Generate Docker Compose
```bash
# Linux/macOS
./generate-compose.sh

# Windows
generate-compose.bat
```

### 3. Start Services
```bash
# Linux/macOS
./start.sh

# Windows
start.bat

# Or start manually
cd docker
docker-compose up -d
```

### 4. Access Services
- **Main Site**: `http://localhost`
- **VS Code**: `http://localhost:8082` (password: student)
- **IRC Chat**: `http://localhost:9000`
- **Minecraft**: Connect to `localhost:25565`
- **Traefik Dashboard**: `http://localhost:8080`

## 📁 Project Structure

```
xiaobox/
├── config.yml              # Global configuration
├── generate-compose.py     # Configuration processor
├── generate-compose.sh     # Generation script (Linux/macOS)
├── generate-compose.bat    # Generation script (Windows)
├── start.sh               # Startup script (Linux/macOS)
├── start.bat              # Startup script (Windows)
├── install.sh             # Installation script (Linux/macOS)
├── install.bat            # Installation script (Windows)
├── docker/
│   ├── docker-compose.yml  # Generated compose file
│   ├── nginx/
│   ├── code-workspace/
│   └── server/
└── public/
    └── eaglercraft.html
```

## 🔧 Advanced Configuration

### Custom Ports
Edit `config.yml` to change any service ports:
```yaml
ports:
  code_server: 3000  # Change VS Code port
  thelounge: 8000     # Change IRC port
```

### Service Management
Disable unwanted services:
```yaml
services:
  minecraft: false    # Disable Minecraft server
  bungeecord: false   # Disable proxy
```

### Security Settings
```yaml
security:
  traefik_insecure: true  # Enable Traefik dashboard
  expose_ports: true      # Expose service ports
```

## 🐛 Troubleshooting

### Common Issues

1. **Port conflicts**: Change ports in `config.yml`
2. **Permission errors**: Ensure Docker has proper permissions
3. **Service not starting**: Check `docker-compose logs <service>`

### Logs
```bash
# View all logs
cd docker && docker-compose logs

# View specific service logs
docker-compose logs code-server
```

## 📚 Services Included

### 🎮 Games
- **Eaglercraft**: Web-based Minecraft 1.12
- **WebXash**: Half-Life and Counter-Strike 1.6

### 💻 Development
- **VS Code Server**: Full IDE in browser
- **Terminal**: Integrated command line

### 💬 Communication
- **TheLounge**: Modern IRC client
- **IRC Server**: Built-in chat server

### 🛠️ Infrastructure
- **Nginx**: Web server and reverse proxy
- **Traefik**: Load balancer and SSL termination
- **Docker**: Containerized deployment

## 🤝 Contributing

We welcome contributions to XIAOBOX! Whether you're fixing bugs, adding features, improving documentation, or suggesting enhancements, your help is appreciated.

### 🚀 Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/yourusername/xiaobox.git
   cd xiaobox
   ```
3. **Set up development environment**:
   ```bash
   # Linux/macOS
   ./install.sh

   # Windows
   install.bat
   ```

### 🛠️ Development Workflow

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-number
   ```

2. **Make your changes** following our guidelines

3. **Test your changes**:
   ```bash
   # Generate and start services
   ./generate-compose.sh && ./start.sh

   # Or on Windows
   generate-compose.bat && start.bat
   ```

4. **Run tests** (if applicable):
   ```bash
   # Test configuration generation
   python generate-compose.py
   ```

5. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```

6. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request** on GitHub

### 📝 Contribution Guidelines

#### Code Style
- **Python**: Follow PEP 8 guidelines
- **YAML**: Use 2-space indentation, clear comments
- **Shell/Batch**: Use descriptive variable names, add comments
- **Docker**: Keep images lightweight, use multi-stage builds when possible

#### Commit Messages
Use conventional commit format:
```
feat: add new service configuration
fix: resolve port conflict issue
docs: update installation instructions
refactor: simplify configuration parser
```

#### Testing
- Test on both Linux/macOS and Windows
- Verify all services start correctly
- Test configuration changes
- Check for port conflicts

### 🎯 Areas for Contribution

#### High Priority
- **Bug fixes** for existing services
- **Documentation improvements**
- **Windows compatibility** enhancements
- **Security improvements**

#### Feature Requests
- **New services** (games, tools, etc.)
- **Configuration options** for existing services
- **Themes and UI improvements**
- **Performance optimizations**

#### Documentation
- **Setup guides** for different platforms
- **Troubleshooting guides**
- **API documentation**
- **Video tutorials**

### 🐛 Reporting Issues

When reporting bugs, please include:
- **Platform** (Windows/Linux/macOS)
- **Docker version**
- **Error logs** (`docker-compose logs`)
- **Configuration** (`config.yml`)
- **Steps to reproduce**

### 💡 Suggesting Features

Feature requests should include:
- **Use case** description
- **Implementation** ideas
- **Potential impact** on existing functionality
- **Mockups** or examples (if applicable)

### 📞 Getting Help

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Documentation**: Check the README and docs folder first

### 🙏 Recognition

Contributors will be:
- Listed in `CONTRIBUTORS.md`
- Mentioned in release notes
- Credited in commit messages

### 📋 Pull Request Checklist

- [ ] Tests pass locally
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Commit messages are clear
- [ ] No breaking changes without discussion
- [ ] Works on both Linux/macOS and Windows

Thank you for contributing to XIAOBOX! 🎉

## 📄 License

This project is open source and available under the MIT License.