## Contributing to github-api-examples 

This is a first cut at sharing the pain between administrators and users of 
GitHub Enterprise who are just starting out playing with JSON and the 
application API.  It is impossible for one person to do it all and the 
greater the number of contributions the greater the usefulness of this 
repository.  In short, anything you're willing to add be it a different 
language or an additional example will be greatly appreicated.
 
This project adheres to the [Open Code of Conduct](./CODE-OF-CONDUCT.md). By participating, you are expected to uphold this code.

## Feature Requests

Feature requests are welcome, but will have a much better chance of being
accepted if they follow the original intent of the project. Github-api-examples is 
for end users, not Github or API  experts. It should be a easily translated into 
the current GitHub API framework with a clear description of the intended function, 
expected options, and a clear use case to maximize its chances for completion

* Each example is clearly terminated and provides an option for exposing the 
underlying command and output

* There is a clear documentation path within the current API documention (https://developer.github.com/v3/) that can be referenced within the example

## Branching strategy

Branching is based on the language used to write the example.
The master branch is reserved primarily for project information
and will not contain any code to start.

## Submitting a pull request

0. [Fork][] and clone the repository
0. Create a new branch based on the code the example will use `: `git checkout -b <my-branch-name> perl`
0. Make your change, add tests, and make sure the tests still pass
0. Push to your fork and [submit a pull request][pr] from your branch to the parent branch
0. Accept the [GitHub CLA][cla]
0. Kick back and relax.  It's time for a review

Here are a few things you can do that will increase the likelihood of your pull request being accepted:

* The sample defines any required variables
* Dependency and variable checks are built into the example. 
* Any environmental dependencies are noted in the sample.
* Including a link to the relevant API documentation used to generate the sample
* Update documentation as necessary. 
* Keep your sample as focused as possible. If there are multiple samples you
would like to make that are not dependent upon each other, consider submitting
them as separate pull requests.
* Write a [good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

### Prerequisites

* Knowledge of the GitHub API, token generation, and access to a GitHub Enterprise server
* Knowledge of token scoping and role permissions within GitHub 
    E.G. What level of access does an application admin have compared to an organization owner?


