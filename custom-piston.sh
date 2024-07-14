#!/bin/bash

# Array of packages to build
packages=(
  "jest-29.7.0.pkg.tar.gz"
  "python-2.7.18.pkg.tar.gz"
  "python-3.5.10.pkg.tar.gz"
  "python-3.9.1.pkg.tar.gz"
  "python-3.9.4.pkg.tar.gz"
  "python-3.10.0.pkg.tar.gz"
  "python-3.11.0.pkg.tar.gz"
  "python-3.12.0.pkg.tar.gz"
)

# Build packages
cd ./packages/
for pkg in "${packages[@]}"; do
  make "$pkg"
done

# Build piston packages
cd ..
for pkg in "${packages[@]}"; do
  name_version="${pkg%.pkg.tar.gz}"
  name="${name_version%-*}"
  version="${name_version##*-}"
  ./piston build-pkg "$name" "$version"
done

# Append new index content to existing index file
cd ./repo/
sudo wget https://github.com/engineer-man/piston/releases/download/pkgs/index -O original-index
grep -vE 'python-[0-9]+\.[0-9]+\.[0-9]+\.pkg\.tar\.gz' original-index | sudo tee -a index > /dev/null