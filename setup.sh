#!/bin/bash

# install homebrew
echo "###############################HOMEBREW#################################"
curl -fsSL https://raw.githubusercontent.com/omimouni/42homebrew/master/install-goinfre.sh | zsh
echo ""

# install jq
echo "##################################JQ####################################"
brew install jq
echo ""

# cloning work
echo "#################################WORK###################################"
mkdir ~/goinfre/work && git clone https://github.com/Jeanmichel7/bot.git ~/goinfre/work
echo""

# install node
echo "#################################NODE###################################"
brew install node
echo""

# install vscode
echo "################################VSCODE##################################"
VSCODE_VERSION=$(curl -s https://formulae.brew.sh/api/cask/visual-studio-code.json | jq .version -r)
curl -L https://update.code.visualstudio.com/$VSCODE_VERSION/darwin/stable -o ~/goinfre/vscode.zip
unzip ~/goinfre/vscode.zip -d ~/goinfre
rm ~/goinfre/vscode.zip
xattr -dr com.apple.quarantine ~/goinfre/Visual\ Studio\ Code.app
mkdir ~/goinfre/code-portable-data
echo ""

# install fzf
#echo "###### INSTALLING FZF ######"
#brew install fzf
#echo ""

# install ripgrep
#echo "###### INSTALLING RIPGREP ######"
#brew install ripgrep
#echo ""

# install cmocka
#echo "###### INSTALLING CMOCKA ######"
#brew install cmocka
#echo ""

# install compiledb
#echo "###### INSTALLING compiledb ######"
#brew install compiledb
#echo ""

# install llvv
#echo "###### INSTALLING LLVM ######"
#brew install llvm
#echo ""

# install jetbrains mono
#echo "###############################JETBRAINS#################################"
#brew tap homebrew/cask-fonts
#brew install --cask font-jetbrains-mono
#echo ""

# install code command in PATH
# echo "##### INSTALLING CODE COMMAND IN PATH"
# cat << EOF >> ~/.zshrc
# Add Visual Studio Code (code)
# export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# EOF
# echo ""
