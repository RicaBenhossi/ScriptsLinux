echo "-------------------- BACKUPING .CONFG ---------------------"
echo
original_path=$(pwd)
echo "Creating temporary backup folder on $original_path"
mkdir ~/bkp_config
echo "Copying .config/ to temporary backup folder"
cp -r ~/.config/ ~/bkp_config/
cd ~/bkp_config
echo "Compacting temporary backup folder"
zip -r -q "$USER"_config.zip .config/
echo
sleep 1s
echo "Moving backup zip file to cloud"
mv "$USER"_config.zip ~/GoogleDrive/backup/
echo "Removing temporary backup folder"
cd $original_path && rm -r ~/bkp_config/
echo
sleep 1s
echo "Backup finished."
