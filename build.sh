#!/usr/bin/env bash
rm -rf output
mkdir output
tar czvf output/lego-widgets.tar.gz src
cd output
cp lego-widgets.tar.gz static-lego-widgets.tar.gz
