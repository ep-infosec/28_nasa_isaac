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

cmake_minimum_required(VERSION 2.8.3)
project(isaac)

# Verify the user has the pre-commit hook
execute_process(
 COMMAND cp ../scripts/git/pre-commit ../.git/hooks
 WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)


find_package(catkin REQUIRED COMPONENTS
  roscpp
)

catkin_package(
  CATKIN_DEPENDS roscpp
)

#############
## Install ##
#############

install(DIRECTORY config/ DESTINATION config)
install(PROGRAMS scripts/env_wrapper.sh DESTINATION . )
install(PROGRAMS scripts/apk_print_version.sh
                 scripts/print_version.sh
                 scripts/cpu_print_version.sh
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})

# Mark launch files for installation
install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
  PATTERN ".svn" EXCLUDE)