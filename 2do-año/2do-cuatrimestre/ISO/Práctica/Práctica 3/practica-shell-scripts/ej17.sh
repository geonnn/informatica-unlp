#!/bin/bash

ls | tr -d "aA" | tr "[:lower:] [:upper:]" "[:upper:] [:lower:]"
