# !/bin/bash

echo "**********************************************************************"
echo "*                Create Virtual Environment - Python                 *"
echo "**********************************************************************"
echo
echo "Your Virtual Environment will be created as the follow:"
echo "   - The name will be by default venv_[name you want]"
echo "   - It will be created on the currently directory"
echo "   - It will be automatically activate"
echo
while true
do
    echo "Enter the name for your Virtual Environment:"
    read venv_user
    if [ $venv_user ]; then
        break
    else
        echo "Name is not valid."
    fi
done
venv_name="venv_$venv_user"
echo
echo "----------------------------------------------------------------------"
echo "             Creating Virtual Environmet named $venv_name             "
echo "----------------------------------------------------------------------"
echo
virtualenv --python=python3.7 "$venv_name"
if [ $? -eq 0 ]; then
    echo " -> Virtual Environment $venv_name successfully created."
else
    echo " -> Fail to create your Virtual Environment. Try Again later."
    exit
fi
echo
echo "Sarting Virtual Environmet $venv_name"
echo
source $venv_name/bin/activate
if [ $? -eq 0 ]; then
    echo "-> Virtual Environment $venv_name successfully started."
else
    echo "-> Fail to start Virtual Environment $venv_name . Try start it manually"
fi
echo
echo "----------------------------------------------------------------------"
echo "                 Installing default packages via pip                  "
echo "----------------------------------------------------------------------"
echo
echo "Do you want to install packages from a pip requirements file [Y/N]?"
while true
do
    read install_package
    install_package=${install_package^^}
    if [ "$install_package" = "Y" ]; then
        echo "Rename your requirements file to 'pip_requirements.txt' and store it on ~/Development."
        echo "Hit [ENTER] when it is ready." && read
        pip3 install -r ~/Development/pip_requirements.txt
        echo
        echo "-> Packages installation complete."
        break
    elif [ "$install_package" = "N" ]; then
        echo "-> No additional packages will be installed."
        break
    else
        echo "Invalid option. Try Y for YES and N for NO."
    fi
done
echo
echo "----------------------------------------------------------------------"
echo "   Virtual Environmet $venv_name is set and ready to use. Enjoy it!   "
echo "----------------------------------------------------------------------"