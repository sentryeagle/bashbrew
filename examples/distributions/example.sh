#!/usr/bin/env sh
#
# examples/distributions/example.sh
#
# Description: Extract distribution codenames from Docker's official images.
#
# Steps:
#   1. Uses the 'bashbrew' Docker container to query available Debian/Ubuntu tags.
#   2. Filters out non-codename tags (stable/development/rolling releases, versions with numbers/hyphens).
#   3. Formats the output as 'distro/codename' pairs.
#
# Note: The 'examples/distributions/format.txt' file contains the Golang 'text/template' template for tag processing.
# See: https://github.com/docker-library/buildpack-deps/blob/d1c98ffcf1a750b96930d99ff46ad2e9d492cbff/versions.sh

make run -- cat debian ubuntu --format-file /mnt/local/examples/distributions/format.txt | jq -r '
    map(select(test("
        # Filter tags to ignore.
        :(
            experimental | rc-buggy # Non-release tags.
            |
            latest | .*stable | devel | rolling | testing # Aliases.
            |
            .* - .* # Anything with hyphens.
            |
            [0-9].* # Anything with numerics.
        )$
    "; "x") | not))

    # Take only the first remaining tag from each group (should be the codename).
    | .[0] // empty

    # Convert colon separator to slash (debian:bookworm → debian/bookworm).
    | sub(":"; "/")
    
    # Output as shell-quoted strings.
    | @sh
'