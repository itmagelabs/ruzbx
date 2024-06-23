# Ruzbx

## Running

    RUZBX_DEBUG=true RUZBX_URL=http://localhost:8080 RUZBX_TOKEN=<ZABBIX_ACCESS_TOKEN> bundle exec ./bin/console

## Usage in the code

## Rake tasks

    rake zabbix:create -- \
        '--name=example' \
        '--templates=Linux by Zabbix agent,Website certificate by Zabbix agent 2' \
        '--ip=127.0.0.1' \
        '--hostgroups=Linux servers'

## Testing

### Run the instance of jira

    docker compose up -d
    open http://localhost:8080
