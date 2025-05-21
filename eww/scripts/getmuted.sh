#!/bin/bash

amixer -D pulse sget Master | awk '/Left:/{print $6}'
