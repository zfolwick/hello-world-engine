# Hello, World!

This project represents an observation that every new project and script has _some_ level of esoteric vocabulary or magical incantation associated with it.

All scripts almost without exception begin with a file that just logs to the console with the executable bit set. This just lets the developer know that they've set up the file correctly.

# Motivation
This process is a coding exercise to flex some basic skills in a coding language I rarely use, using a style I only just became aware of. I also wanted to reduce the overhead of context-switching into a different language. That being said, C is a horrendously difficult language when compared to bash and I was able to whip out a bash script in an evening that did everything I wanted and is extensible with a minor amount of effort.


# How to use
1. Clone this repo.
2. Pick a language binding (e.g., `./bash/hw help`) and RTFM.
3. Create a new hello world app in the language of your choice (so long as it's supported.
4. Rename and/or move the app wherever you want.  It's not supposed to stay here.

## Tests
They're under the `tests/` directory. Run `BINDING=c bats test/unit_tests.bats` to execute the suite of tests against C.

## How you know it's ready
There's only two steps:
1. Create the file (via `./hw <TARGET_LANGUAGE>` in the `<TARGET_LANGUAGE>` directory)
2. The tests pass

If it takes more than those two steps, it's not ready.

# Making modifications
Push up a PR. That's how open source works.


# Adding languages
Implement a hello world in a target language, add it to the `lib` directory. Then modify `bash/hw` script to add the option to the switch case if you feel it's ready.

The bash implementation was the first one implemented.  The folder structure and file implementation was determined here.  The C implementation literally was implemented via this prompt: 

```
translate this to C

#!/usr/bin/env bash
... the bash implementation of hw
```

Python was implemented in the _exact same way_.

