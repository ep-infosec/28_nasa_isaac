#!/bin/bash
#
# Copyright (c) 2021, United States Government, as represented by the
# Administrator of the National Aeronautics and Space Administration.
#
# All rights reserved.
#
# The "ISAAC - Integrated System for Autonomous and Adaptive Caretaking
# platform" software is licensed under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with the
# License. You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# This image is split into two, because we need to copy over the toolchain
# folder and rootfs folder. Because docker can only access files in the
# build context, and we don't want it to scan the entire computer by
# chosing a bigger build context, this is the easiest solution. This also
# allows the user to place the folders freely.
set -e

# Base docker image copies over the toolchain and rootfs, resulting from
# the NASA_INSTALL.md instructions. Also installs minimum dependencies
echo "Build for isaac: "
if ! docker build . -f scripts/docker/cross_compile/isaac_cross.Dockerfile -t isaac:cross
then
  exit 1
fi
echo "Copying from the docker container to ${PWD}/../isaac_cross...."
mkdir ${PWD}/../isaac_cross/
docker run --rm --entrypoint tar isaac:cross cC /opt/isaac . | tar xvC ${PWD}/../isaac_cross/
