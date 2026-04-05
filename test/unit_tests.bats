log() {
  echo "${1}" >&3
}

[ -n "${BINDING:-}" ] || {
  log "Error: BINDING is unset or empty. Try BINDING=bash to test bash language bindings"
  false
}

setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  LANG_UNDER_TEST="${BINDING:?BINDING must be set}"

  #
  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  # make executables in src/ visible to PATH
  SRC="$(pwd)"
  PROJ_ROOT="$SRC/$LANG_UNDER_TEST"

  PATH="$PATH:$PROJ_ROOT"
}

teardown() {
  rm -f "${PROJ_ROOT}/helloworld.sh" "./helloworld.sh"
  popd
}

@test "can run our script" {
  pushd "$PROJ_ROOT"
  run hw bash
}

@test "running script creates expected file" {
  pushd "$PROJ_ROOT"
  run hw bash

  [ -f "helloworld.sh" ] || { echo "Expected helloworld.sh after running the bash hello world creation script"; false; }
}

@test "run without params needs language" {
  pushd "$PROJ_ROOT"
  run hw
  assert_output --partial "Need language"
  assert_output --partial "Usage:"
  assert_output --partial "Example:"

}

@test "hw creates a file for every lib/*.hw integration" {
  pushd "$PROJ_ROOT"
  shopt -s nullglob

  for f in ./../lib/*.hw; do
    lang="${f##*/}"
    lang="${lang%.hw}"

    # snapshot existing outputs
    before="$(ls -1 ./helloworld.* 2>/dev/null)"

    run ./hw "$lang"
    [ "$status" -eq 0 ] || { echo "lang=$lang failed: ${output:-}" >&3; false; }

    # snapshot after
    after="$(ls -1 ./helloworld.* 2>/dev/null)"

    # find newly created files (set difference)
    new="$(comm -13 <(printf '%s\n' "$before") <(printf '%s\n' "$after") || true)"

    [ -n "$new" ] || { echo "lang=$lang: no new ./helloworld.* created" >&3; false; }

    # assert each new file exists + cleanup
    while IFS= read -r file; do
      [ -f "$file" ] || { echo "lang=$lang: missing $file" >&3; false; }
      rm -f "$file"
    done <<<"$new"
  done
}

@test "the created helloworld script prints [Hello, World] to the console" {
  pushd "$PROJ_ROOT"
  for f in ./../lib/*.hw; do
    lang="${f##*/}"
    lang="${lang%.hw}"
 
    local hw_text
    hw_text="Hello, World"

    # Create the file 
    run ./hw "$lang"

    # Run the program
    ext=$(sed -n '2p' "./../lib/$lang.hw" | sed 's/.*://; s/[()[:space:]]//g')
    run ./helloworld.$ext

    # Assert the output
    assert_output --partial "$hw_text"

    # clean up test
    rm -f "${PROJ_ROOT}/helloworld.$ext" "./helloworld.$ext"
  done
}

@test "parameterizing the output works" {
  pushd "$PROJ_ROOT"
  local param="test user"
  for f in ./../lib/params/*.hw; do
    lang="${f##*/}"
    lang="${lang%.hw}"
 
    local hw_text
    hw_text="Hello, $param!"

    # Create the file 
    run ./hw "$lang" -p

    # Run the program
    ext=$(sed -n '2p' "./../lib/$lang.hw" | sed 's/.*://; s/[()[:space:]]//g')
    run ./helloworld.$ext "test user"

    # Assert the output
    assert_output "$hw_text"

    # clean up test
    rm -f "${PROJ_ROOT}/helloworld.$ext" "./helloworld.$ext"
  done

}
