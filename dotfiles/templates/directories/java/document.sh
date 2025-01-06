#!/bin/bash

command="javadoc src/*.java
        -cp lib/*.jar 
        -d docs/"

echo "Documenting via: ${command}"

$command
