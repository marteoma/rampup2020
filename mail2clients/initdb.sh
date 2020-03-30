#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    CREATE USER $DATABASE_USERNAME WITH PASSWORD '$DATABASE_PASSWORD';
    CREATE DATABASE mail2clients;
    GRANT ALL PRIVILEGES ON DATABASE mail2clients TO $DATABASE_USERNAME;
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres --dbname mail2clients <<-EOSQL
    CREATE TABLE IF NOT EXISTS email_logger (
    log_id            SERIAL                      NOT NULL,
    log_serial        VARCHAR(100)                NOT NULL,
    log_subject       VARCHAR(100)                NOT NULL,
    log_delivered     BOOL                        NOT NULL DEFAULT 'false',
    log_content       VARCHAR(2500)               NOT NULL,
    log_timestamp     TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT current_timestamp
    ) WITH (OIDS =FALSE);
    ALTER TABLE email_logger OWNER TO $DATABASE_USERNAME;

    DROP DATABASE postgres;
EOSQL