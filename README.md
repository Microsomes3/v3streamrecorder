

#Goals

Much cleaner channel flows <- ><-- use directional channels to indicate if its a write or real channel

Active Watchdog that watches for any errors

Cleaner codebase

Error Resistent

Ability to handle mutiple job requests


Each Step in the record process should go through its own independant workflow

ENV:
    runningmode: api keeps api server running | adhoc = runs once then dies

Steps:

- Receive Job Request <- via api request | also when spinning up a manifest link can be passed to execute once
    - Record Request -> Requires a manifest link

- Determine if capacity is available then schedules for recording, if no capacity will send a request to liveclipper, complaining rejecting it


- if capacity schedules for recording

- Handle any sigterm signals

- Keep listening for any rtc connection, kill request for a recording




#Architecture plan

We want to be able to run yt-dlp in a controlled environment as this sometimes fails we need ability to restart execution, cleanup etc


Command (yt-dlp (audio record request)) -> Big DOG WATCHDOG -> Doggies 
    1 Dog= Duration requested killer dog
    2 Dog = Check if any temp file exists = yt-dlp is trying to mux and we don't want it to
    3 Dog = Check if command is executing as normal, if not report back to Big Dog to let it know


Big Watchdog is responsible for making sure the commands are progressing as normal if not, i will get a report from my doggies, doggy number 3 will work like a heart beat if a report hasnt come is some time, it will kill the command and restart it



Big DOG DOG Watch Dog- Responsible for all the Big Dog Watchdogs

If any big dog watchdogs fail for whatever reason we will restart it


We need some sort of database and a good logging solution


#AIMS

Better logging with slog

Better control with an api server to control what the system does

Better Error Handling, and retry abilities

Manage system specs to avoid over-capacity situations

Queue Management to handle multiple jobs and cleanup after job is done to avoid 

Allow multiple s3 compatible storage solutions, create an storage interface to replace storage solution easily