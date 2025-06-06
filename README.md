# HOLX DOCKER DEVCONTAINER ENV

### Headless Installations
 - NET
 - Node
 - TypeScript
 - MSSQL

### Management Tools
 - NVM
 - Git

### APPAREANCE
 - oh-my-szh (Terminal Theme)

 ## Info ℹ️

 Installing any tools, cli or headless application is as easy as pressing and holding Ctrl then P on vscode,
 - Dev Containers: Configure containers features
 - Select the "feature" you want to add to your existing environment
 - I think you'll be prompted to rebuild the image


 ## ATTENTION 🚨
 If error at build time is _postCreateCommand from devcontainer.json failed with exit code 2_
 change the line style of the .sh files by going to the bottom right of VScode and changing from CRLF to LF
 then rebuild the image