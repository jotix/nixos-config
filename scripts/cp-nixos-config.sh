### copy nixos-config folder to the new installation

echo "Changing nixos-config origin repo"
git remote remove origin
git remote add origin git@github.com:jotix/nixos-config.git
sudo cp -rv ~/nixos-config /mnt/home/jotix/
sudo nixos-enter --command 'chown -R jotix /home/jotix/nixos-config'
