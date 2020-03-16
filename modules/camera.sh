#!/bin/bash

function camera::kill() {
  sudo killall AppleCameraAssistant
  sudo killall VDCAssistant
}
