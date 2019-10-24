:: clone the repo
set remote_repo_url="https://github.com/karthikneelaiyan/bootstrap.git"
git clone --single-branch  --branch core_crm_branch https://github.com/karthikneelaiyan/bootstrap.git
:: get the  msi file
set home_dir=D:\CICD\test1\git\bootstrap
cd %home_dir%
git pull --all
git clean -fd
git checkout -f test_installer
cd %home_dir%\installer
dir *.msi /b > tmpFile 
set /p msi_file_name= < tmpFile 
del tmpFile 
set msi_file_name=%home_dir%\installer\%msi_file_name%
:: extract the folder structure from msi file
set target_loc=%home_dir%\source
msiexec "/a %msi_file_name% /q TARGETDIR=%target_loc%"
cd %target_loc%
:: push to source branch in repo
git add -A
git commit -m "msi extracted files added"
git push  