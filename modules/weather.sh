#!/bin/bash

function weather::long() {
  curl "http://v2.wttr.in.$1"
}

