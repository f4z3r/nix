set shell := ["bash", "-c"]

dir := justfile_directory()
home := env_var('HOME')

backup DRIVE:
  @[ -d /mnt/drive ] || sudo mkdir /mnt/drive
  sudo mount /dev/{{ DRIVE }} /mnt/drive
  rsync -vau {{ home }}/Music/ /mnt/drive/music
  rsync -vau --exclude='**/.git/' --exclude='**/target/' {{ home }}/Documents/ /mnt/drive/docs
