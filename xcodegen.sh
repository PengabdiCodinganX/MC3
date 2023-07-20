#!/bin/bash

# Script to run XcodeGen
# Run this script from the terminal like: ./run_xcodegen.sh

# Check if xcodegen is installed
if ! command -v xcodegen &> /dev/null
then
    echo "XcodeGen could not be found"
    exit
fi

# Change this to your actual path to project.yml
PROJECT_YML="MC3/project.yml"

if [ ! -f "$PROJECT_YML" ]; then
    echo "Project.yml does not exist at the specified path: $PROJECT_YML"
    exit
fi

# Run XcodeGen
xcodegen generate --spec "$PROJECT_YML"
echo "XcodeGen has finished generating the project."