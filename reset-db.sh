#!/bin/bash

# Connect to matrix.metal.men server
ssh matrix.metal.men

# Switch to root user
sudo su

# Stop Matrix Synapse server
systemctl stop matrix-synapse

# Connect to Matrix Postgres Docker container
docker exec -it matrix-postgres bash

# Connect to Postgres database
psql matrix

# Remove all active connections to synapse database
SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'synapse';

# Drop synapse database
DROP DATABASE synapse;

# Exit Postgres
\q

# Exit Postgres Docker container
exit

# Disconnect from matrix.metal.men server
exit

# Run just setup-all command
just setup-all --ask-vault-pass

# Comment out application service so that it doesn't block creation of room in homeserver.yml
# Restart matrix-synapse service
systemctl restart matrix-synapse

# Create Admin user
just register-user jhmakki makk1adm1n yes --ask-vault-pass

# Create METAL Bot metal-bot with admin access using 

# Login with a user
# Verify if the all-member-disucssion room is created
# Uncomment appservice lines from homeserver.yml

# Restart matrix-synapse service
systemctl restart matrix-synapse 