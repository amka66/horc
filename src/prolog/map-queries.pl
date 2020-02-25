%
%   Copyright 2020 Amir Kantor
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.
%

% ___File name:___ map-queries.pl

% ___File purpose:___ A Prolog script performing queries on the Horn knowledge
% base `map.hn` for testing and demonstration.

% Prolog Script
% =============

:- horn(key(d), 1).

:- \+ horn(key(e), 1).

:- horn(value(1), 1).

:- \+ horn(value(2), 1).

:- horn(map(cons(cons(nil,a,0),b,1)), 1).

:- horn(not_defined(d, cons(cons(nil,a,0),b,1)), 1).

:- horn(maps_to(cons(cons(nil,a,0),b,1), a, 0), 1).

:- \+ horn(map(cons(cons(nil,a,0),a,1)), 1).

:- \+ horn(not_defined(a, cons(cons(nil,a,0),b,1)), 1).

:- \+ horn(maps_to(cons(cons(nil,a,0),b,1), a, 1), 1).

:- \+ horn(maps_to(cons(cons(nil,a,0),b,1), c, 0), 1).
