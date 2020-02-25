#
#   Copyright 2020 Amir Kantor
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

# ___File name:___ run.sh

# ___File purpose:___ Interface script exectued first (top) when a Docker 
# container starts, and receiving its parameters from the command line.

echo "Running horc..."

if [ -z "$1" ]; then
    echo "ERROR! Missing CLI argument: path to a Horn knowledge base is missing."
    exit 1
fi

FILENAME_HORN="$1"
FILENAME_PROLOG="${2:-/dev/null}"

# Note that the path to horc within the docker image is `/app/horc/`:
bash /app/horc/src/bash/create-temp-files-and-run-swipl.sh "$FILENAME_HORN" \
    "$FILENAME_PROLOG"
