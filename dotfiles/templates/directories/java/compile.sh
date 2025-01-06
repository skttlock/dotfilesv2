#!/bin/bash

command="javac
        src/*.java
        -d bin"

echo "Compiling via: ${command}"

$command
