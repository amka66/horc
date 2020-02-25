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

# ___File name:___ create-temp-files-and-run-swipl.sh

# ___File purpose:___ Invoked by `run.sh` and assembles everything together.
# (1) Creating a temporary Prolog module that wraps a Horn knowledge base
# `<horn_file>`. (2) Creating a temporary Prolog script that loads the 
# temporary module, `horn-interpreter.pl`, and an optional Prolog script 
#`<prolog_file>`. (3) Invoking SWI-Prolog on the temporary script.

FILENAME_HORN="$1"
FILENAME_PROLOG="$2"

# Note that the path to horc within the docker image is `/app/horc/`:

# Create a temporary Prolog module that wraps a Horn
# knowledge base, and exposes two defined predicates -- one returning clauses
# in the knowledge base, and the other adds new clauses to the knowledge base.
cat > /app/horc/var/temp-module.pl << EOF
:- module(temp_module, [horn_pl__clause/2, horn_pl__asserta/1]).

:- ensure_loaded('$FILENAME_HORN').

horn_pl__clause(Head, Body) :-
    clause(Head, Body).

horn_pl__asserta(Clause) :-
    asserta(Clause).
EOF

# Create a temporary Prolog script that is to be executed as the top file.
cat > /app/horc/var/temp-loaded.pl << EOF
:- use_module('/app/horc/var/temp-module.pl').

:- ensure_loaded('/app/horc/src/prolog/horn-interpreter.pl').

:- ensure_loaded('$FILENAME_PROLOG').
EOF
# NOTE In the generated file, I don't see the need to declare dynamic
# predicates (via `dynamic`). # TODO Check why.
# NOTE In the generated file, new predicates can be later added via `[user].` 
# to be found by the horn interpreter (say, `horn/2`). # TODO Try to prevent.

# Execute SWI-Prolog:
swipl -f /app/horc/var/temp-loaded.pl
