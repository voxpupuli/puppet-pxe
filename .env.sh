#! /bin/bash

if [ -x ~/.rbenv/bin/rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(~/.rbenv/bin/rbenv init -)"
fi
