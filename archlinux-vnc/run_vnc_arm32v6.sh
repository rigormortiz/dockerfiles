#!/bin/bash
# Script to run VNC in docker container

# Check to see if we have run before
STATUS_FILE=/.setup_complete
if [ -f $STATUS_FILE ]; then
    SETUP_COMPLETE=1
else
    SETUP_COMPLETE=0
fi

# Set defaults
DEFAULT_USERNAME="desktop"
DEFAULT_VNC_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
DEFAULT_GEOMETRY="1024x768"
DEFAULT_DPI="96"

# Get command-line arguments 
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--username)
    USERNAME="$2"
    shift # past argument
    shift # past value
    ;;
    -p|--vnc-password)
    VNC_PASSWORD="$2"
    shift # past argument
    shift # past value
    ;;
    -g|--geometry)
    GEOMETRY="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--dpi)
    DPI="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done

# Setup variables
MY_USERNAME=${USERNAME:-$DEFAULT_USERNAME}
MY_VNC_PASSWORD=${VNC_PASSWORD:-$DEFAULT_VNC_PASSWORD}
MY_GEOMETRY=${GEOMETRY:-$DEFAULT_GEOMETRY}
MY_DPI=${DPI:-$DEFAULT_DPI}

if [ "$SETUP_COMPLETE" = "0" ]; then
    # Echo things out
    echo "This is the first run!"
    echo USERNAME     = "${MY_USERNAME}"
    echo VNC_PASSWORD = "${MY_VNC_PASSWORD}"
    echo GEOMETRY     = "${MY_GEOMETRY}"
    echo DPI          = "${MY_DPI}"

    # Create user
    useradd -m -s /bin/bash ${MY_USERNAME}

    # Set DPI and resolution
    mkdir -p /home/${MY_USERNAME}/.vnc && chown ${MY_USERNAME}:${MY_USERNAME} /home/${MY_USERNAME}/.vnc
    echo "geometry=${MY_GEOMETRY}" | su -c "tee -a /home/${MY_USERNAME}/.vnc/config" - ${MY_USERNAME}
    echo "dpi=${MY_DPI}" | su -c "tee -a /home/${MY_USERNAME}/.vnc/config" - ${MY_USERNAME}
    echo "Xft.dpi: ${MY_DPI}" | su -c  "tee -a /home/${MY_USERNAME}/.Xresources" - ${MY_USERNAME}

    # Set VNC password
    echo "${MY_VNC_PASSWORD}" | vncpasswd -f > /home/${MY_USERNAME}/.vnc/passwd
    chown ${MY_USERNAME}:${MY_USERNAME} /home/${MY_USERNAME}/.vnc/passwd
    chmod 0400 /home/${MY_USERNAME}/.vnc/passwd

    # Setup complete status
    touch /.setup_complete
else
    echo "Setup has already run... starting!"

    # Run some cleanup
    if [ -f /tmp/.X1-lock ]; then
        rm /tmp/.X1-lock
        rm /tmp/.X11-unix/X1 
    fi
fi

# Start VNC Server, trap sig and tail log
trap '{ vncserver -kill :1; killall -9 tail; exit 0}' SIGTERM
su -c vncserver - ${MY_USERNAME}
tail -f /home/${MY_USERNAME}/.vnc/*log

