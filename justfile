set shell := ["bash", "-c"]

dir := justfile_directory()
home := env_var('HOME')

backup:
  @[ -d /mnt/drive ] || sudo mkdir /mnt/drive
  sudo mount /dev/sda1 /mnt/drive
  rsync -vau --delete-after {{ home }}/Music/ /mnt/drive/music
  rsync -vau --delete-after --delete-excluded --exclude='**/.git/' --exclude='**/target/' {{ home }}/Documents/ /mnt/drive/docs
