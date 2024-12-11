
JTX_CONFIG_GIT=git@github.com:jotix/jtx-config.git

config() {
  git --git-dir=$HOME/.jtx-config/ --work-tree=$HOME $@
}

cd $HOME
git clone --bare $JTX_CONFIG_GIT $HOME/.jtx-config

### make copy af existing files
mkdir -p $HOME/.jtx-config-backup
config checkout 2>&1 | grep -E "\s+\." | xargs -I '{}' mv -v '{}' $HOME/.jtx-config-backup

config checkout

config config --local status.showUntrackedFiles no
