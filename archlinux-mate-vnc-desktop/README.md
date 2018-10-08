### Info
This is an Archlinux image suitable for my uses as a Mate VNC "desktop" environment. I have installed packages that I find useful in a pinch. You may or may not find it useful so feel free to modify.

### Flags
The image takes the following flags at run time:

`-u|--username` (optional, default: desktop)
`-p|--vnc-password` (optional, default: randomly generate) -  see docker logs for output
`-g|--geometry` (optional, default: 1024x768)

### Run Example
Images based off of this would run something like: 
```
docker run -d -P rigormortiz/archlinux-mate-vnc-desktop:latest -u myuser -p mypassword -g 1920x1080 
```

### Setting up sudo
If you would like to use sudo (useful for installing AUR packages and such) there are some manual steps you should execute. I didn't want it in the default image, so I did not automate it in.

```
docker run -d --name arch -P rigormortiz/archlinux-mate-vnc-desktop:latest -u myuser -p mypassword -g 1920x1080
docker exec -it arch passwd myuser
docker exec -it arch gpasswd -a myuser wheel
docker stop arch
docker start arch
```
