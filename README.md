# Hello, World!

This project represents an observation that every new project and script has _some_ level of esoteric vocabulary or magical incantation associated with it.

All scripts almost without exception begin with a file that just logs to the console with the executable bit set. This just lets the developer know that they've set up the file correctly.

# Motivation
This process is a coding exercise to flex some basic skills in a coding language I rarely use, using a style I only just became aware of. I also wanted to reduce the overhead of context-switching into a different language. That being said, C is a horrendously difficult language when compared to bash and I was able to whip out a bash script in an evening that did everything I wanted and is extensible with a minor amount of effort.


# How to use
1. Clone this repo.
3. Run `./bash/hw.sh help` and RTFM.
4. Create a new hello world app in the language of your choice (so long as it's supported.
5. Rename and/or move the app wherever you want.  It's not supposed to stay here.

# Next steps
## Re-implement in several language bindings
I plan on re-implementing the core bash script in C, go, rust, and node as a simple coding exercise in creating CLI tooling.

## Command Patterns
I also plan on ridding myself of the switch-case in favor of a command pattern. But a switch-case is pretty standard in bash, so in the interest of doing a small thing and not letting perfect be the enemy of good enough, I used a switch for the bash implementation. As I mature in my scripting, I'm finding it somewhat limiting, as adding new functionality has more overhead than I feel is necessary. I should be able to drop a new functionality into `lib` and have it just work.

## Tests
Since I'd like to refactor this multiple times in multiple ways, having a suite of automated acceptance tests is going to be necessary.

# Adding languages
Implement a hello world in a target language, add it to the `lib` directory. Then modify `bash/hw.sh` script to add the option to the switch case if you feel it's ready.

## How you know it's ready
There's only two steps:
1. Create the file (via `./hw.sh <TARGET_LANGUAGE>` in the `bash` directory)
2. Run the file (via `./helloworld.cpp`, for a C++ example)

If it takes more than those two steps, it's not ready.

# Making modifications
Push up a PR. That's how open source works.
