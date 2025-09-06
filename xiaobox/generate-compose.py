#!/usr/bin/env python3
"""
XIAOBOX Docker Compose Generator
Generates docker-compose.yml from config.yml
"""

import yaml
import os
import sys
from pathlib import Path

def load_config():
    """Load configuration from config.yml"""
    config_path = Path(__file__).parent / "config.yml"
    if not config_path.exists():
        print("Error: config.yml not found!")
        sys.exit(1)

    with open(config_path, 'r') as f:
        return yaml.safe_load(f)

def generate_docker_compose(config):
    """Generate docker-compose.yml content from config"""

    compose = {
        'version': config['docker']['compose_version'],
        'networks': {
            config['network']['name']: {
                'driver': config['network']['driver']
            }
        },
        'services': {}
    }

    # Traefik
    if config['services'].get('traefik', False):
        compose['services']['traefik'] = {
            'image': 'traefik:v2.10',
            'container_name': 'traefik',
            'command': [
                '--api.insecure=true',
                '--providers.docker=true',
                f'--entrypoints.web.address=:{config["ports"]["nginx"]}',
                f'--entrypoints.web9000.address=:{config["ports"]["thelounge"]}'
            ],
            'ports': [
                f'{config["ports"]["nginx"]}:{config["ports"]["nginx"]}',
                f'{config["ports"]["traefik_dashboard"]}:{config["ports"]["traefik_dashboard"]}',
                f'{config["ports"]["thelounge"]}:{config["ports"]["thelounge"]}'
            ],
            'volumes': [
                '/var/run/docker.sock:/var/run/docker.sock:ro'
            ],
            'networks': [config['network']['name']]
        }

    # Nginx
    if config['services'].get('nginx', False):
        compose['services']['nginx'] = {
            'build': './nginx',
            'container_name': 'nginx',
            'labels': [
                'traefik.enable=true',
                'traefik.http.routers.nginx.rule=Host(`localhost`)',
                'traefik.http.routers.nginx.entrypoints=web',
                'traefik.http.services.nginx.loadbalancer.server.port=80'
            ],
            'volumes': [
                f'{config["paths"]["public"]}:/usr/share/nginx/html:ro'
            ],
            'networks': [config['network']['name']]
        }

    # TheLounge
    if config['services'].get('thelounge', False):
        compose['services']['thelounge'] = {
            'build': {
                'context': '.',
                'dockerfile': 'thelounge.Dockerfile'
            },
            'container_name': 'thelounge',
            'volumes': [
                './thelounge-config.js:/var/opt/thelounge/config.js'
            ],
            'labels': [
                'traefik.enable=true',
                'traefik.http.routers.thelounge.rule=Host(`localhost`)',
                'traefik.http.routers.thelounge.entrypoints=web9000',
                'traefik.http.services.thelounge.loadbalancer.server.port=9000'
            ],
            'networks': [config['network']['name']]
        }

    # Minecraft
    if config['services'].get('minecraft', False):
        compose['services']['mc'] = {
            'image': 'itzg/minecraft-server:java8-multiarch',
            'environment': [
                'EULA=TRUE',
                f'VERSION={config["minecraft"]["version"]}',
                f'ONLINE_MODE={str(config["minecraft"]["online_mode"]).lower()}'
            ],
            'volumes': [
                f'{config["paths"]["server_data"]}/mc:/data'
            ],
            'networks': [config['network']['name']]
        }

    # Bungeecord
    if config['services'].get('bungeecord', False):
        compose['services']['bungeecord'] = {
            'image': 'itzg/bungeecord',
            'environment': [
                'TYPE=WATERFALL',
                f'CFG_MOTD={config["minecraft"]["motd"]}',
                'REPLACE_ENV_VARIABLES=true'
            ],
            'volumes': [
                './eagler-bungeecord-config.yml:/config/config.yml',
                f'{config["paths"]["server_data"]}/bungee:/server'
            ],
            'networks': [config['network']['name']]
        }

    # Code Server
    if config['services'].get('code_server', False):
        compose['services']['code-server'] = {
            'image': 'linuxserver/code-server:latest',
            'container_name': 'code-server',
            'ports': [
                f'{config["ports"]["code_server"]}:8443'
            ],
            'volumes': [
                f'{config["paths"]["code_workspace"]}:/config/workspace',
                '/tmp/code-server:/config/.local/share/code-server'
            ],
            'environment': [
                f'PASSWORD={config["code_server"]["password"]}',
                f'DEFAULT_WORKSPACE={config["code_server"]["workspace"]}'
            ],
            'networks': [config['network']['name']],
            'restart': config['docker']['restart_policy']
        }

    return compose

def main():
    """Main function"""
    print("XIAOBOX Docker Compose Generator")
    print("===============================")

    # Load configuration
    config = load_config()
    print(f"Loaded configuration from config.yml")

    # Generate docker-compose.yml
    compose = generate_docker_compose(config)

    # Write to docker-compose.yml
    output_path = Path(__file__).parent / "docker" / "docker-compose.yml"
    with open(output_path, 'w') as f:
        yaml.dump(compose, f, default_flow_style=False, sort_keys=False)

    print(f"Generated docker-compose.yml at {output_path}")
    print("\nEnabled services:")
    for service, enabled in config['services'].items():
        if enabled:
            print(f"  ✅ {service}")

    print("\nTo apply changes, run:")
    print("  cd docker")
    print("  docker-compose down")
    print("  docker-compose up -d")

if __name__ == '__main__':
    main()