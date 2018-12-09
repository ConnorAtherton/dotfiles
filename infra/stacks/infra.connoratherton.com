upstream git_ui {
  server 127.0.0.1:8080;
}

upstream docker_registry {
  server 127.0.0.1:5000;
}

server {
  listen 443 ssl;
  server_name g.infra.connoratherton.com;

  # SSL configuration
  ssl_session_cache shared:SSL:10m;
  ssl_session_timeout  24h;
  # Use a higher keepalive timeout to reduce the need for repeated handshakes
  # default = 75 secs
  keepalive_timeout 300;
  # disable for poodle vulnerability
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

  ssl_certificate /etc/ssl/live/infra.connoratherton.com/fullchain.pem;
  ssl_certificate_key /etc/ssl/live/infra.connoratherton.com/privkey.pem;
  ssl_stapling on;
  ssl_stapling_verify on;
  ssl_trusted_certificate /etc/ssl/live/infra.connoratherton.com/chain.pem;

  # Security headers
  add_header X-Frame-Options DENY;
  add_header X-XSS-Protection "1; mode=block";

  location / {
    auth_basic           "Authenticate (g):";
    auth_basic_user_file /etc/nginx/htpasswd;

    proxy_pass http://git_ui;

    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  }
}

server {
  listen 443 ssl;
  server_name r.infra.connoratherton.com;

  # SSL configuration
  ssl_session_cache shared:SSL:10m;
  ssl_session_timeout  24h;
  # Use a higher keepalive timeout to reduce the need for repeated handshakes
  # default = 75 secs
  keepalive_timeout 300;
  # disable for poodle vulnerability
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

  ssl_certificate /etc/ssl/live/infra.connoratherton.com/fullchain.pem;
  ssl_certificate_key /etc/ssl/live/infra.connoratherton.com/privkey.pem;
  ssl_stapling on;
  ssl_stapling_verify on;
  ssl_trusted_certificate /etc/ssl/live/infra.connoratherton.com/chain.pem;

  # Security headers
  add_header X-Frame-Options DENY;
  add_header X-XSS-Protection "1; mode=block";

  # disable any limits to avoid HTTP 413 for large image uploads
  client_max_body_size 0;

  # required to avoid HTTP 411: see Issue #1486 (https://github.com/docker/docker/issues/1486)
  chunked_transfer_encoding on;

  location /v2/ {
    auth_basic           "Authenticate (r):";
    auth_basic_user_file /etc/nginx/htpasswd;
    add_header 'Docker-Distribution-Api-Version' 'registry/2.0' always;

    proxy_pass http://docker_registry;

    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header  X-Real-IP         $remote_addr; # pass on real client's IP
    proxy_set_header  X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header  X-Forwarded-Proto $scheme;
    proxy_read_timeout                  900;
  }
}
