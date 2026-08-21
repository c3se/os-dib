# diskimage-builder configs for cloud image build automation

## Prerequisites

Create a virtual environment .venv in this directory and install `python-openstackclient` and `diskimage-builder`. Add a clouds.yaml file with administrative rights to push out public images.

The tested working setup for building all images I've found is using a total of 3 VM:s. You might be able to cut it down with enough effort but there is a risk that you will run into filesystem issues if you for example try to use Fedora to build Rocky 9 images.

1. Rocky 9 - builds `rocky9` and `alma9`.
2. Fedora 44 - builds `fedora44`.
3. Debian 13 - builds `debian13` and `ubuntu24`.

## Deployment

If you don't want to publicly deploy your built image, you can change `--public` to `--private` in `deploy.sh` and add a project ID to it.

## Cronjob for build and deployment

You can copy or symlink openstack-autobuild@.service and openstack-autobuild@.timer, and then do `systemctl enable openstack-autobuild@$DISTRO.timer`.
