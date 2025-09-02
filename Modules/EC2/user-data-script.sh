#!/bin/bash
yum update -y
yum install -y ec2-instance-connect
systemctl restart sshd

MOUNT_EBS=${mount_ebs}
MOUNT_EFS=${mount_efs}

if [ "$MOUNT_EBS" = "true" ]; then
    # Wait for the EBS device to appear
    timeout=30
    count=0
    while [ ! -e /dev/sdb ]; do
        sleep 1
        count=$((count+1))
        if [ $count -ge $timeout ]; then
            echo "Device /dev/sdb did not appear after $timeout seconds"
            exit 1
        fi
    done

    # Format if not formatted
    if ! file -s /dev/sdb | grep ext4; then
        mkfs -t ext4 /dev/sdb
    fi

    # Create mount point
    mkdir -p /data

    # Mount the volume
    mount /dev/sdb /data

    # Add to fstab for persistence
    grep -qxF '/dev/sdb /data ext4 defaults,noatime,nofail 0 2' /etc/fstab || echo '/dev/sdb /data ext4 defaults,noatime,nofail 0 2' >> /etc/fstab
fi

if [ "$MOUNT_EFS" = "true" ]; then
    # Create mount point if it doesn't exist
    mkdir -p /efs-mountpoint

    # Wait until EFS DNS resolves
    timeout=30
    count=0
    until nslookup "${efs_dns}" >/dev/null 2>&1; do
        sleep 1
        count=$((count+1))
        if [ $count -ge $timeout ]; then
            echo "EFS DNS ${efs_dns} could not be resolved after $timeout seconds"
            exit 1
        fi
    done

    # Mount EFS if not already mounted
    if ! mountpoint -q /efs-mountpoint; then
        mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport \
        "${efs_dns}:/" /efs-mountpoint
    fi

    # Add to fstab for persistence
    grep -qxF "${efs_dns}:/ /efs-mountpoint nfs4 defaults,_netdev 0 0" /etc/fstab || \
        echo "${efs_dns}:/ /efs-mountpoint nfs4 defaults,_netdev 0 0" >> /etc/fstab
fi
