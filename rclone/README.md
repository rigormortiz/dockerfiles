### Info
This is an Alpine Linux image with rclone. It can be used for adhoc or scheduled clones of docker volumes or firectories.

I don't usually like to run things as root by default, but I can see where this use case could be an exception. By all means, feel free to add the `-u` flag to the `docker run` command to run as a backup user.

### Example Usage

```
# run config, i.e., to add a remote or set config password
docker run -it -v ${HOME}/.config/rclone:/root/.config/rclone rigormortiz/rclone config

# run copy to backup files from the "some_data" volume to a remote called "remote" in the "backup" path/directory
docker run -it -v ${HOME}/.config/rclone:/root/.config/rclone -v some_data:/data rigormortiz/rclone copy /data remote:backup

# run copy to restore files from a remote called "remote" in the "backup" path/directory to the "some_data" volume
docker run -it -v ${HOME}/.config/rclone:/root/.config/rclone -v some_data:/data rigormortiz/rclone copy remote:backup /data
```

### Copying Permissions
rclone does not have the ability to copy permissions. I've included a work around for this by including `get_facl.sh` and `set_facl.sh` scripts that can be used to do this.

#### Example Backup Script

```
#!/bin/bash

# Backup ACLs/permissions
sudo docker run --rm \
    --volume some_data:/data \
    --entrypoint "/get_facl.sh" \
    rigormortiz/rclone \
    /data

# Backup /data
sudo docker run -it --rm \
    --volume ${HOME}/.config/rclone:/root/.config/rclone \
    --volume some_data:/data \
    rigormortiz/rclone \
    copy /data remote:backup
```

#### Example Restore Script

```
#!/bin/bash

# Restore /data
sudo docker run -it --rm \
    --volume ${HOME}/.config/rclone:/root/.config/rclone \
    --volume some_data:/data \
    rigormortiz/rclone \
    copy remote:backup /data

# Restore ACLs/permissions
sudo docker run --rm \
    --volume some_data:/data \
    --entrypoint "/set_facl.sh" \
    rigormortiz/rclone \
    /data
```