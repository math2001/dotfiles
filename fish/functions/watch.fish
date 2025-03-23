# Function arguments: $argv
# first argument: $argv[1]
# see argparse

function youwatch
  firefox "https://invidious.perennialte.ch/watch?v=$argv[1]"
end
