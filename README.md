# RubySec Field Guide
In the last year, many new vulnerabilities and vulnerability classes have been discovered in Ruby applications. These vulnerabilities make use of features specific to the Ruby language and common idioms present in large Ruby projects, such as serialization and deserialization of data in the YAML format. As these vulnerability classes were initially discovered in popular and well-studied open source software, it’s extremely likely that they occur in applications throughout the Ruby ecosystem. These applications frequently represent lucrative targets for attackers, and with the appearance of new and easily exploitable bug classes, the potential for targeted and mass exploitation of Ruby programs has been demonstrated to the world. In this training, we aim to bridge a knowledge and skills gap by bringing information about these new vulnerability classes to software developers.

This training will cover the recent Ruby on Rails vulnerabilities classes, their root causes, and include demonstrations and exercises where students develop exploits for real-world vulnerabilities. Students will learn the patterns behind the vulnerabilities and develop software engineering strategies to avoid introducing vulnerabilities of this type into their projects.

## Students Will Learn
 * The mechanics and root causes of the recent Rails vulnerabilities
 * Methods for mitigating the impact of deserialization flaws
 * How attackers can rootkit Rack-based applications via YAML deserialization
 * Mitigations techniques for YAML deserializations flaws
 * Defensive Ruby programming techniques
 * Best practices for API design
 * Advanced testing techniques and fuzzing with Mutant

## Prerequisites
Students should have an intermediate level of understanding of Ruby. Students must bring their own laptops with Ruby >= 1.9.2 installed (you can use RVM to do this).

In order to help prospective students evaluate whether they are prepared for this course, take this short self-assessment questionnaire. Students should be able to answer these questions with relative ease in order to get the most out of the course.

 * Are you familiar with the command line?
 * Have you ever refactored existing Ruby code?
 * Have you ever written unit tests?
 * Have you ever written YAML by hand?
 * Have you ever used `instanceeval`, `classeval`, or `module_eval`?

### Credits

who wrote this, contributors, etc.
