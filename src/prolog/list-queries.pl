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

% ___File name:___ list-queries.pl

% ___File purpose:___ A Prolog script performing queries on the Horn knowledge
% base `list.hn` for testing and demonstration.

% Prolog Script
% =============

:- horn(element(1), 1).

:- \+ horn(element(2), 1).

:- horn(list(nil), 1).

:- horn(list(cons(cons(nil,0),0)), 1).

:- horn(list(cons(cons(nil,0),1)), 1).

:- \+ horn(list(cons(cons(nil,0),2)), 1).

:- horn(concat(nil, nil, nil), 1).

:- horn(concat(cons(nil,0), cons(nil,1), cons(cons(nil,0),1)), 1).

:- horn(not_member(0, nil), 1).

:- horn(not_member(0, cons(nil,1)), 1).

:- \+ horn(not_member(1, cons(nil,1)), 1).

:- \+ horn(member(0, nil), 1).

:- \+ horn(member(0, cons(nil,1)), 1).

:- horn(member(1, cons(nil,1)), 1).

:- horn(not_equal(nil, cons(nil, 0)), 1).

:- horn(not_equal(cons(nil,0), cons(nil,1)), 1).

:- \+ horn(not_equal(cons(nil,0), cons(nil,0)), 1).
