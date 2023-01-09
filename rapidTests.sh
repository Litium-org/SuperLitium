#!/bin/bash
if [ -d build/ ]
then
	rm -rdv build/
	mkdir build/
else
	mkdir build/
fi
