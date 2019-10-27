echo "-------------------- BACKUPING .CONFG ---------------------"
echo
echo "Compacting .Config folder"
original_path=$(pwd)
mkdir ~/bkp_config
cp -r ~/.config/ ~/bkp_config/
cd ~/bkp_config
zip -r -q ricabenhossi_config.zip .config/
echo
sleep 1s
echo "Moving zip file to cloud"
mv ricabenhossi_config.zip ~/GoogleDrive/backup/
cd $original_path && rm -r ~/bkp_config/
echo
sleep 1s
echo "Backup Done."
