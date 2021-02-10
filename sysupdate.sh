# !/bin/bash
echo
echo "***********************************************************"
echo "*                                                         *"
echo "*                    UPDATING SYSTEM                      *"
echo "*                                                         *"
echo "***********************************************************"
echo
echo "-------------- Collecting packages to update --------------"
echo
cp ~/.bash_aliases ~/Scripts/
sudo apt-fast update;
# Copy list of apps that has updates
sudo apt list --upgradable >>  ~/Scripts/packages_with_updates;
echo "-------------------- Performing update --------------------"
echo
have_updates=$(wc -l < ~/Scripts/packages_with_updates);
if [ "$have_updates" -gt 1 ]; then
    sudo apt-fast dist-upgrade -y;
fi

# Clean up the system
sudo apt-fast autoclean;
sudo apt-fast clean;
sudo apt-fast autoremove -y;
echo

echo "---------------- Updating Flatpak packages ----------------"
echo
flatpak update

# Check if code-indiders was updated and is open. If it's true, closes it and reopen.
if [ "$have_updates" -gt 1 ]; then
    echo "---------------- Checking apps to restart -----------------"
    echo
    if (grep "code-insiders" ~/Scripts/packages_with_updates); then
        # Check if code-insiders is open.
        if (pidof code-insiders > 0); then
            echo "Updates available for VSCode"
            echo "Restarting to apply updates"
            killall -9 -q pidof code-insiders;
            DISPLAY=:0 code-insiders && echo "VSCode update..........DONE"
            echo
        fi
    fi

    # Check if firefox-trunk was updated and is open. If it's true, closes it and reopen.
    if (grep "firefox-trunk" ~/Scripts/packages_with_updates); then
        # Check if firefox-trunk is open.
        if (pidof firefox-trunk > 0); then
            echo "Update available for Firefox"
            echo "Restarting to apply updates";
            pkill firefox-trunk -f;
            sleep 2s
            DISPLAY=:0 nohup env firefox-trunk &
            echo "Firefox update........ DONE"
            echo
        fi
    fi

    if (grep "skypeforlinux" ~/Scripts/packages_with_updates); then
        # Check if code-insiders is open.
        if (pidof skypeforlinux > 0); then
            echo "Updates available for Skype"
            echo "Restarting to apply updates"
            killall -9 -q pidof skypeforlinux;
            DISPLAY=:0 skypeforlinux;
            echo "Skype update..........DONE"
            echo
        fi
    fi
    echo "Checking apps to restart complete..."
    echo
fi
# Removing packages_wit_updates
echo "--------------------- Cleanning files ---------------------"
echo
echo "Removing packages_with_updates"
sudo rm -f ~/Scripts/packages_with_updates;
echo "DONE"
echo
echo "Removing 0"
sudo rm -f ~/0;
sudo rm -f 0;

echo "DONE"
echo
echo "Removing nohup.out"
sudo rm -f ~/nohup.out;
sudo rm -f nohup.out;
echo "DONE"
echo
sleep 2s
echo "--------------------- Update finished ---------------------"
echo
