# !/bin/bash

echo "**********************************************************************"
echo "*                Create Virtual Environment - Python                 *"
echo "**********************************************************************"
echo
echo "Your Virtual Environment will be created as the follow:"
echo "   - The name will be by default ve.[name you want]"
echo "   - It will be created on the currently directory"
echo "   - It will be automatically activate"
echo
cp ~/.bash_aliases ~/Scripts/
if [ "$1" = "" ]; then
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
else
    echo "Name already passed as parameter: $1"
    venv_user="$1"
fi
venv_name="ve.$venv_user"
echo
echo "----------------------------------------------------------------------"
echo "             Creating Virtual Environmet named $venv_name             "
echo "----------------------------------------------------------------------"
echo
sleep 2s
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
. $venv_name/bin/activate
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
while true
do
    read -p "Do you want to install packages from a pip requirements file [Y/N]? " install_package
    install_package=${install_package^^}
    if [ "$install_package" = "Y" ]; then
        echo
        echo "Rename your requirements file to 'pip_requirements.txt'."
        custom_path=""
        while true
        do
            pip_file=pip_requirements.txt
            if test -f "$pip_file" ; then
                echo "Pip requirements file found. Start installing packages from pip_requirements.txt."
                custom_path=$(pwd)
            else
                if [ "$custom_path" = "" ]; then
                    echo
                    read -e -p "Type the path to directory where the pip_requirements.txt is saved: " -i $HOME/ custom_path
                fi
            fi
            if [ -d "$custom_path" ]; then
                file=$custom_path/pip_requirements.txt
                if test -f "$file"; then
                    pip3 install -r $custom_path/pip_requirements.txt
                    echo
                    echo "-> Packages installation complete."
                    break
                else
                    echo
                    echo "File pip_requirements.txt not found in this directory."
                    while true
                    do
                        echo
                        read -p "Do you want to inform another directory path to install from pip_requirements.txt? [Y/N]: " user_answer
                        user_answer=${user_answer^^}
                        if [ "$user_answer" = "Y" ]; then
                            custom_path=''
                            break
                        elif [ "$user_answer" != "N" ]; then
                            echo
                            echo "Invalid option. Try again."
                        else
                            echo
                            echo "Save file pip_requirements.txt on the directory '$custom_path'."
                            echo "Press [ENTER] when it is ready."
                            read
                            break
                        fi
                    done
                fi
            else
                echo
                echo "Directory not found."
                custom_path=''
            fi
        done
        break
    elif [ "$install_package" = "N" ]; then
        echo "-> No additional packages will be installed."
        break
    else
        echo "Invalid option. Try Y for YES and N for NO."
    fi
done
echo
echo "##### Virtual Environmet $venv_name is set and ready to use. Enjoy it! #####"