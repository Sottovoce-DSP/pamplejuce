#!/bin/bash

# How to run:
# Step 1: chmod +x fetch-submodules.sh
# Step 2: ./fetch-submodules.sh

# Define commit hashes as variables
JUCE_COMMIT="1e5c88899eba2aac16b687784d7d9c8bf066ab27"
CMAKE_COMMIT="b2e4cb69ec06fad1aff453aab39dac90493adb0c"
MELATONIN_INSPECTOR_COMMIT="ac5595d21b308e18aa2de140c28edb9e7c2adc22"

# Remove any existing submodule references from Git's index
echo "Removing existing submodule entries..."
git submodule deinit -f JUCE
git submodule deinit -f modules/melatonin_inspector
git submodule deinit -f cmake
rm -rf .git/modules/JUCE .git/modules/modules/melatonin_inspector .git/modules/cmake

# Clear out the physical directories
echo "Removing existing submodule directories..."
rm -rf JUCE modules/melatonin_inspector cmake

# Remove any existing submodule references from Git's index
echo "Removing existing submodule entries..."
git rm -rf JUCE modules/melatonin_inspector cmake

# Remove the folders first
rm -rf JUCE modules/melatonin_inspector cmake

# Add the submodules
git submodule add -b develop https://github.com/juce-framework/JUCE JUCE
git submodule add -b main https://github.com/sudara/melatonin_inspector.git modules/melatonin_inspector
git submodule add -b main https://github.com/sudara/cmake-includes.git cmake

echo "Updating submodules to specified commits..."

# Update JUCE submodule
cd JUCE
git fetch
git checkout "$JUCE_COMMIT"
cd ..
echo "JUCE submodule updated to $JUCE_COMMIT."

# Update cmake submodule
cd cmake
git fetch
git checkout "$CMAKE_COMMIT"
cd ..
echo "cmake submodule updated to $CMAKE_COMMIT."

# Update melatonin_inspector submodule
cd modules/melatonin_inspector
git fetch
git checkout "$MELATONIN_INSPECTOR_COMMIT"
cd ../..
echo "melatonin_inspector submodule updated to $MELATONIN_INSPECTOR_COMMIT."

# Commit the updated submodule references
echo "Committing submodule updates..."
git add JUCE cmake modules/melatonin_inspector
git commit -m "Update submodules to match speedshift repository"

echo "Submodule update complete."