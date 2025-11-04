#!/bin/bash

ls -l *


tr -d "aA" | tr "[:lower:] [:upper:]" "[:upper:] [:lower:]"
