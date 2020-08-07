# Local Time Lab

`localtimelab` is a Docker container for tinkering with the local time/time zone of a Docker container.

## Background

While working with different Docker containers I realized that there are –at least– two ways to set the local time/time zone in a container:

1. Setting the environment variable `TZ` (example `-e TZ="Asia/Phnom_Penh"`).
2. Add a bind mount to `/etc/localtime` on the host (`-v /etc/localtime:/etc/localtime:ro`).

The first way seems to be the most common way to set the local time/time zone. The second way does not work on _macOS_ and _Windows_ host,  because `/etc/localtime` is not available on these systems.

I had already "added" the way via `-e TZ="Europe/Berlin"` to [an image](https://github.com/thoschworks/cups-airprint-bjnp/commit/c1ed357e1583353efdf0902ef69ddb4bba088f9e) (there was nothing to do except adding the repository `tzdata`...). 

After stumbling over this thread in the [_linuxserver.io Disourse_](https://discourse.linuxserver.io/t/binding-etc-localtime-maybe-more-convenience-for-timezone-setting/1783) I wanted to dig a little bit deeper.

## The image

 It is a minimal image with an _Alpine Linux_ as base, one additional image (`tzdata`) and a script, which is calling `date` (Yes, I could also put `date` directly into the `CMD`…).
 
## Usage

Just run the container with these four configurations and see:

```
docker run --rm \
  thoschworks/localtimelab
``` 

```
docker run --rm \
  -e TZ="Asia/Phnom_Penh" \
  thoschworks/localtimelab
```

```
docker run --rm \
  -v /etc/localtime:/etc/localtime:ro \
  thoschworks/localtimelab
```

```
docker run --rm \
  -e TZ="Asia/Phnom_Penh" \
  -v /etc/localtime:/etc/localtime:ro \
  thoschworks/localtimelab
```

The first three examples work as expected. To my big surprise `-e TZ="…"` supersedes `-v /etc/localtime …` in the fourth example.
