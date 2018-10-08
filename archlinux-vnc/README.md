### Info
This is an Archlinux image with only the basic packages needed to get a usable TigerVNC setup. It is best to use this as a base image since there is no desktop or window manager provided.

### Flags
The image takes the following flags at run time:

`-u|--username` (optional, default: desktop)
`-p|--vnc-password` (optional, default: randomly generated, see docker logs for output)
`-g|--geometry` (optional, default: 1024x768)

### Run Example for image based on this one
Images based off of this would run something like: 
```
docker run -d <image_name> -u myuser -p mypassword -g 1920x1080
```
