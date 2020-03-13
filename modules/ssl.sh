#!/bin/bash

function ssl::fetch_certs() {
  openssl s_client -showcerts -connect "$1:443" </dev/null
}
