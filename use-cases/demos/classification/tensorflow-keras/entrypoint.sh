#!/bin/bash
#
# Copyright (C) 2024 Intel Corporation.
#
# SPDX-License-Identifier: Apache-2.0
#

# generate unique container id based on the date with the precision upto nano-seconds
cid=$(date +%Y%m%d%H%M%S%N)
echo "cid: $cid"

PROFILE_NAME="demo_tensorflow_keras_classification"

python3 classification/tensorflow-keras/tensorflow_keras_classification.py \
-m "$MQTT_HOSTNAME" -p "$MQTT_PORT" -t "$MQTT_TOPIC" -i "$INPUT_SRC" | tee >/tmp/results/r"$cid"_"$PROFILE_NAME".jsonl >(stdbuf -oL sed -n -e 's/^.*FPS: //p' | stdbuf -oL cut -d , -f 1 > /tmp/results/pipeline"$cid"_"$PROFILE_NAME".log)
