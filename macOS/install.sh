sudo softwareupdate -i -a

# Install Homebrew if not present
which -s brew
if [[ $? != 0 ]] ; then 
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update && brew upgrade
fi

# Install brew packages
while IFS='' read -r line || [[ -n "$line" ]]; 
do 
    brew install "$line"
done < brewfile

npm install npm -g
npm update -g
