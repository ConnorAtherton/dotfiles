Deep dives into extremely specific problems frequently encountered conducted business
with a binary machine.

## Software Diffing

Ultimately a comparison problem with multiple inputs.

Algorithms:
- http://www.xmailserver.org/diff2.pdf
- https://en.wikipedia.org/wiki/Needleman%E2%80%93Wunsch_algorithm

Uses heuristics:
- https://github.com/Distrotech/diffutils/blob/distrotech-diffutils/lib/diffseq.h#L255
- https://github.com/git/git/blob/master/xdiff/xdiffi.c#L143

## Dates, Timezones -- the epoch and the gregorian calendar

- Why do we even have an epoch?
- How do we store dates?
  -> in the past: UTC
  -> In the future: UTC + timezone from tzdatabase

Joda time, Noda time libs have lots of date and time logic included.

https://www.youtube.com/watch?v=-5wpm-gesOY

