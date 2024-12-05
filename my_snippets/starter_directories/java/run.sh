#!/bin/bash

command="java 
        -cp bin:lib/* Main";

echo "Running via: ${command}"

$command
