# Ruby Security Field Guide
In the last year, many new vulnerabilities and vulnerability classes have been discovered in Ruby applications. These vulnerabilities make use of features specific to the Ruby language and common idioms present in large Ruby projects, such as serialization and deserialization of data in the YAML format. Since these vulnerability classes were initially discovered in popular and well-studied open source software, it’s extremely likely that they occur in applications throughout the Ruby ecosystem. Ruby applications frequently represent lucrative targets for attackers, and with the appearance of new and easily exploitable bug classes, the potential for targeted and mass exploitation of Ruby programs has been demonstrated to the world.

In these exercises, we aim to bridge a knowledge and skills gap by bringing information about these new vulnerability classes to software developers.

These exercises cover the recent vulnerabilities classes, their root causes, and include demonstrations and exercises where students develop exploits for real-world vulnerabilities. Readers will learn the patterns behind the vulnerabilities and develop software engineering strategies to avoid introducing similar vulnerabilities into their projects.

## Readers Will Learn
 * How attackers can rootkit Rack-based applications via YAML deserialization
 * Mitigations techniques for YAML deserializations flaws
 * Defensive Ruby programming techniques
 * Advanced testing techniques and fuzzing with Mutant

## Prerequisites
Readers should have an intermediate level of understanding of Ruby and a laptop with Ruby >= 1.9.2 installed (you can use RVM to do this).

In order to help prospective readers evaluate whether they are prepared for this course, take this short self-assessment questionnaire. You should be able to answer these questions with relative ease in order to get the most out of the exercises.

 * Are you familiar with the command line?
 * Have you ever refactored existing Ruby code?
 * Have you ever written unit tests?
 * Have you ever written YAML by hand?
 * Have you ever used `instanceeval`, `classeval`, or `module_eval`?
