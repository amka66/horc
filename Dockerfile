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

# ___File name:___ Dockerfile

# ___File purpose:___ Docker script for building a Docker image.

FROM swipl:8.0.3
LABEL maintainer="Amir Kantor <amir.kantor@gmail.com>"
COPY ./ /app/horc/
RUN mkdir /app/horc/var
RUN mkdir /app/horc/included
RUN mv /app/horc/src/horn/*.hn /app/horc/included/
RUN mv /app/horc/src/prolog/*-queries.pl /app/horc/included/
WORKDIR /app/horc/included
ENTRYPOINT ["bash", "/app/horc/src/bash/run.sh"]
