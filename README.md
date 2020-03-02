# `horc`: A Lightweight Horn-Clause Interpreter #

## Features ##

* A free and open-source lightweight [interpreter](https://en.wikipedia.org/wiki/Interpreter_(computing)) of [Horn clauses](https://en.wikipedia.org/wiki/Horn_clause), called `horc`, currently for educational use.
  * A Horn clause is nothing but a [rule of inference](https://en.wikipedia.org/wiki/Rule_of_inference).
  * This way, a set of Horn clauses forms an [inductive definition](https://en.wikipedia.org/wiki/Recursive_definition).
  * Horn clauses constitute a simple [logic](https://en.wikipedia.org/wiki/Logic), called [__Horn logic__](https://www.w3.org/2005/rules/wg/wiki/Horn_Logic), more commonly known as 'pure' [logic programming](https://en.wikipedia.org/wiki/Logic_programming).

* Horn logic may serve as a minimalist __meta-formalism__ in which other more complex [formalisms](https://en.wikipedia.org/wiki/Formal_system) may be defined.
Included with `horc` are the complete definitions of the following formalisms ([syntax](https://en.wikipedia.org/wiki/Syntax_(logic)) and [semantics](https://en.wikipedia.org/wiki/Semantics_of_logic)):
  * Toy formalisms of '[lists](https://en.wikipedia.org/wiki/List_(abstract_data_type))' and '[maps](https://en.wikipedia.org/wiki/Associative_array)' -- included to illustrate Horn logic in use.
  * The computational model of [Turing machines](https://en.wikipedia.org/wiki/Turing_machine) -- demonstrating the computational power of Horn logic, and an interesting object of study in its own.
  * [Horn logic](https://en.wikipedia.org/wiki/Horn_clause) itself -- demonstrating more of the expressive power of Horn logic in its ability to define itself, and serving as a concise formal specifications document of Horn logic.
  * [First-order logic](https://en.wikipedia.org/wiki/First-order_logic), as well as the complete formalization of mathematics in Horn logic using `horc`, are included in a follow-up project -- see [here](https://github.com/amka66/mai).
  This, yet again, is a demonstration of the expressive power of Horn logic, and the effectiveness of our approach.

* `horc` is packaged within a [Docker](https://en.wikipedia.org/wiki/Docker_(software)) image hosted in [Docker Hub](https://hub.docker.com).
Therefore, it requires no installation and can be executed with a single command on any computer with Docker (in the first usage, internet connection is needed).
  * Under the hood, `horc` is implemented in [Prolog](https://en.wikipedia.org/wiki/Prolog) (a computationally-efficient sibling of Horn logic) and operates within a Prolog environment.

* The interpreter is [sound](https://en.wikipedia.org/wiki/Soundness) and [complete](https://en.wikipedia.org/wiki/Completeness_(logic)) for Horn logic:
  * *Load* a Horn _knowledge base_ file consisting of a set of Horn clauses.
  * Then, *query* the knowledge base using a dedicated script, or via an interactive session.
  If the knowledge base defines a computational model, a query might correspond to making a calculation; if the knowledge base defines a logic, a query might correspond to proving a theorem.
  This is where knowledge bases are put into use.
  * The interpreter supports higher layers of automation, via Prolog, without compromising the logic.

* `horc` should be considered an educational tool and proof-of-concept.
  * There are currently *no* optimizations of runtime performance.
  * Supporting capabilities that are needed in order to make this into an industrial-strength IDE are missing.
  
  [//]: # (This primarily refers to more efficient proof search, possibly using high-level human directions and prescribed heuristics; namely, proof assistance. The proper way to do it may be forming a layer of automation that produces a Horn-logic proof artifact, and then do efficient proof checking. We may also need a debugger -- can we use a Prolog debugger?)

## Who is it For? ##

> We invite others who share our vision to join us in making this into an industrial-strength free and open-source framework for representing all sorts of knowledge, and making inferences from it.

## Where to Begin? ##

Our implementation of `horc` celebrates the close relationship between Horn logic and Prolog -- both being different realizations of the logic programming paradigm.
Specifically, `horc` is implemented in Prolog and embedded within a Prolog environment (via Prolog's support for 'meta-interpreters').
This makes advanced language features available in a lightweight implementation of Horn logic, without compromising the logic (for instance, an easy way the define concrete syntax and syntactic sugar).
However, it also means that in order to *use* the `horc` interpreter, in addition to conceptual understanding of Horn logic, some level of *practical* knowledge of Prolog is necessary too.
First, querying Horn knowledge bases and operating with them is done in a Prolog environment.
Second, Horn knowledge bases use standard Prolog notation for the Horn clauses.
*Developing* for `horc`, in contrast to merely using it, requires deeper understanding of Prolog, and, in particular, the meta-interpreter architecture. A list of resources is included in the following.

## How to Execute? ##

If you have [Docker](https://en.wikipedia.org/wiki/Docker_(software)) on your computer, `horc` can be automatically downloaded and executed with *no* need for local installation (nor cloning the project repository).
In the command prompt, simply enter the following:

```$ docker container run [-it] [--rm] [-v <local_dir>:<container_dir> ...] <docker_hub_user_id>/horc <horn_file> [<prolog_file>]```

* `<docker_hub_user_id>` (mandatory): User ID in Docker Hub that currently stores the docker image.
Use `amka66`. __TODO__ Upload image!

* `<horn_file>` (mandatory): Path to a __Horn knowledge base__ file (optionally ending with the extension `.hn`), consisting of a set of Horn clauses, and written in Prolog notation.
It is to be loaded and consulted by the interpreter.
The path is within the container (consider option `-v` below to access the host machine).
Included knowledge bases that can be used here: `list.hn` and `map.hn` (toy examples), `tm.hn` (the computational model of Turing machines), and `horn.hn` (Horn logic itself).

* `<prolog_file>` (optional): Path to a __Prolog script__ file (optionally ending with the extension `.pl`), written in ISO-compliant or SWI-Prolog-compliant Prolog.
If present, it is to be loaded and executed after loading `<horn_file>`.
It may be used for executing queries, testing the knowledge base, defining shell (top-level) functions, and for the initialization of an interactive Prolog session with the user.
The path is within the container (consider option `-v` below to access the host machine).
Included scripts that can be used here: `list-queries.pl`, `map-queries.pl`, `tm-queries.pl`, `horn-queries.pl`, which run queries on the corresponding knowledge bases (see `<horn_file>`) and put them into use.

* `-it` (optional): Option for `docker container run`, which, in our case, sets an interactive Prolog session with the user, after loading and executing `<horn_file>` and `<prolog_file>` (if present).

* `-v <local_dir>:<container_dir> ...` (optional): Option for `docker container run`, which mounts a local directory (within the host machine) to a specified mount point (directory) within the container.
The mount point should be used for referring to files in the host machine (Horn knowledge bases and Prolog scripts), as all prescribed paths are within the container. Note that a list of such pairs can be given.

* `--rm` (optional): Option for `docker container run`, which purges the container once it has stopped running.
Unless you would like to examine the container after it has stopped, it is safe to use this option and avoid keeping obsolete containers.

### Examples ###

`$ docker container run --rm amka66/horc list.hn list-queries.pl`  
Load the included Horn knowledge base `list.hn`, then load and execute the included Prolog script `list-queries.pl`.

`$ docker container run -it --rm amka66/horc horn.hn`  
Load the included Horn knowledge base `horc.hn` and start an interactive Prolog session with the user.

`$ docker container run --rm -v ~/my-files:/mount amka66/horc tm.hn /mount/tm-queries.pl`  
Load the included Horn knowledge base `tm.hn`, then load and execute a Prolog script stored locally in `~/my-files/tm-queries.pl`.

`$ docker container run -it --rm -v ~/my-files:/mount amka66/horc /mount/kb.hn /mount/queries/kb-queries.pl`  
Load a Horn knowledge base stored locally in `~/my-files/kb.hn`, load and execute a Prolog script stored locally in `~/my-files/queries/kb-queries.pl`, and start an interactive Prolog session with the user.

## Overview of Source Code ##

The following is an account of all files in the repository.

File | Directory | Description
---- | --------- | -----------
`horn-interpreter.pl` | `src/prolog` | The core of the project. A lightweight implementation of a Horn-clause interpreter in [ISO Prolog](https://en.wikipedia.org/wiki/Prolog#ISO_Prolog).
`run.sh` | `src/bash` | Bash script serving only as interface. Executed first (top) when a Docker container starts, and receiving its parameters from the command line.
`create-temp-files-and-run-swipl.sh` | `src/bash` | Invoked by `run.sh`, this Bash script assembles everything together. (1) It creates a temporary Prolog module that wraps the Horn knowledge base `<horn_file>`. (2) It creates a temporary Prolog script that loads the temporary module, `horn-interpreter.pl`, and an optional Prolog script `<prolog_file>`. (3) It invokes [SWI-Prolog](https://en.wikipedia.org/wiki/SWI-Prolog) on the temporary script.
`list.hn`, `map.hn`, `tm.hn`, `horn.hn` | `src/horn` | Horn knowledge bases included as examples. Horn-clause definitions of the toy formalisms of 'lists' and 'maps', Turing machines, and Horn logic itself (respectively).
`list-queries.pl`, `map-queries.pl`, `tm-queries.pl`, `horn-queries.pl` | `src/prolog` | Prolog scripts that run queries on the corresponding knowledge bases in directory `src/horn` and put them into use.
`build-docker.sh`, `run-docker.sh`, `test-docker.sh` | `bin` | Bash utility scripts for developers: building a Docker image, running a Docker image in a container, and testing a Docker image.
`Dockerfile` | `.` | Docker script for building a Docker image.
`.dockerignore` | `.` | A list of files to be excluded in Dockerfile's copy command.
`.gitignore` | `.` | A list of files to be excluded from Git.
`horc.bib` | `.` | BibTeX file containing project's bibliography.
`LICENSE` | `.` | License file (plain text).
`README.md` | `.` | This file (Markdown).

## List of Resources ##

* As a main comprehensive resource for the `horc` project, which we find quite understandable, rigorous, and highly aligned with our approach, we may suggest:
[Sterling, Leon, and Ehud Y. Shapiro. _The Art of Prolog: Advanced Programming Techniques._ MIT Press, 2nd edition, 1994.](https://books.google.com/books?hl=en&lr=&id=w-XjuvpOrjMC&oi=fnd&pg=PR14&dq=related:ZL81VhpV5gIJ:scholar.google.com)
It is a classic text by Sterling and Shapiro on Prolog and logic programming (pure logic programming is a synonym for Horn logic).
It covers both our object of study (namely, Horn logic), which is fed in the form of knowledge bases into `horc`, as well as the framework in which `horc` is written; namely, Prolog.
'The Art of Prolog' starts with Horn logic and Horn knowledge bases (called there 'logic programs'), and describes their semantics from several points of view -- both their inductive nature and the computation used to resolve queries.
Then, it moves to Prolog and its semantics, and, in particular, emphasizes the close relationship between the two formalisms.
The book also discusses Prolog meta-interpreters, which is the architecture chosen for `horc`.

* On the contrary, in order to start playing with `horc` and the included material right away, one may consult [Learn Prolog Now!](http://www.learnprolognow.org/lpnpage.php?pageid=online), which is a quick introduction to Prolog available online.

* We should also mention the following text by Winskel, mainly as inspiration:
[Winskel, Glynn. _The Formal Semantics of Programming Languages: An Introduction._ MIT Press, 1993.](https://books.google.com/books?hl=en&lr=&id=JzUNn6uUxm0C&oi=fnd&pg=PA1&ots=1XqmnnVv1o&sig=zLryVTHlxXqP--GRmwSFxkptGGM)
It is a valuable resource on the structure and the kind of mathematics needed in order to properly define and reason about programming languages, and formal systems in general.
It begins with a separation between concrete syntax and abstract syntax trees.
Then, it emphasizes the *inductive* nature of formal systems: from the inductive construction of the expressions of language; through the central role played by rules of inference in defining semantics; to an account of the generalized theory of induction that is needed in order to reason about these constructions.
The usage of Horn logic as a meta-formalism for describing more complex formalisms can be viewed as a simplification of the approach conveyed by Winskel.

### Other Resources ###

* A classic text with comprehensive material on Prolog:
[Clocksin, William F., and Christopher S. Mellish. _Programming in Prolog: Using the ISO Standard._ Springer Science & Business Media, 5th edition, 2003.](https://books.google.com/books?hl=en&lr=&id=wuERBwAAQBAJ&oi=fnd&pg=PA1&dq=related:3-oVFLFL9QMJ:scholar.google.com)

* Collection of all Prolog language features available online:
[SWI-Prolog Reference Manual](https://www.swi-prolog.org/pldoc/doc_for?object=manual).

* A great resource specifically on writing meta-interpreters in Prolog that are similar to `horc`:
[A Couple of Meta-interpreters in Prolog](https://www.metalevel.at/acomip) from the website [_The Power of Prolog_](https://www.metalevel.at/prolog).

* A short manifesto describing Horn logic and it's relation to Prolog:
[Horn Logic (W3C RIF-WG Wiki)](https://www.w3.org/2005/rules/wg/wiki/Horn_Logic).

* A solid comprehensive treatment of Horn logic:
[Lloyd, John W. _Foundations of Logic Programming._ Springer Science & Business Media, 2nd edition, 2012.](https://books.google.com/books?hl=en&lr=&id=TeKpCAAAQBAJ&oi=fnd&pg=PA1&dq=related:5Zktp44nhMkJ:scholar.google.com)
The more relevant characterization of Horn knowledge bases (called there 'definite programs') -- their inductive nature and the soundness and completeness of SLD-resolution -- begins in Chapter 2.

* An in-depth treatments of the semantics of Horn logic, starting by defining it:
[Dantsin, Evgeny, Thomas Eiter, Georg Gottlob, and Andrei Voronkov. "Complexity and Expressive Power of Logic Programming." _ACM Computing Surveys (CSUR)_ 33, no. 3 (2001): 374-425.](https://dl.acm.org/doi/abs/10.1145/502807.502810)

* The following book chapter presents a generalized theory of induction and inductive definitions:
[Aczel, Peter. "An Introduction to Inductive Definitions." In _Studies in Logic and the Foundations of Mathematics_, vol. 90, pp. 739-782. Elsevier, 1977.](https://www.sciencedirect.com/science/article/pii/S0049237X08711200)
It covers monotone induction and its variants, and, particularly, subsumes the inductive principles arising in Horn logic.

* A classic text on Turing machines, computability, and complexity theory:
[Sipser, Michael. _Introduction to the Theory of Computation._ Cengage Learning, 3rd edition, 2012.](https://books.google.com/books?hl=en&lr=&id=1aMKAAAAQBAJ&oi=fnd&pg=PP1&dq=related:Cya4-tNEhcAJ:scholar.google.com)

* Our motivation of turning *mathematical* definitions of logical systems and computational models into *working* systems -- is largely inspired by the following text:
[Harrison, John. _Handbook of Practical Logic and Automated Reasoning._ Cambridge University Press, 2009.](https://books.google.com/books?hl=en&lr=&id=lYSYLPWJQKMC&oi=fnd&pg=PR11&dq=related:g7PYBeQ45dAJ:scholar.google.com)
Harrison's text emphasizes the connection between logic and computation, and provides quite a bit of background on these two notions.
It follows a distinctive, practical, approach to logic, and, similarly to our Horn knowledge-base definitions, its makes _code_ a first-class citizen in a text on logic and formal systems.
Harrison adopts functional programming as his meta-formalism.
It is interesting to compare functional programming and Horn logic in that regard. 
Horn logic may perhaps be considered more of a 'logical system' (with Horn knowledge-base definitions being closer to mathematics than programming) while functional programming being more of a 'computational model', but there are reasons to believe that there is no sharp distinction between the two terms.

__TODO__ Mention also [Isabelle](https://en.wikipedia.org/wiki/Isabelle_(proof_assistant))'s meta-formalism, and compare.

__NOTE__ More info about `horc` and the included material may be found in commit `ba191a15a8`, directory `doc`.

__TODO__ Add a short paper to arXiv, and include a BibTeX entry for citation.

__TODO__ Go over todos.

## License ##

Copyright 2020 Amir Kantor

Licensed under the Apache License, Version 2.0  -- see `LICENSE.txt`.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
