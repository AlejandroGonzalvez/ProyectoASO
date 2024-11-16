#!/bin/bash
#Identificar los cinco procesos que mas memoria consumen
ps aux --sort=-%mem | head -n 6 | tail -n 5
#Identificar los cinco procesos que mas CPU concumen
ps aux --sort=-%cpu | head -n 6 | tail -n 5
