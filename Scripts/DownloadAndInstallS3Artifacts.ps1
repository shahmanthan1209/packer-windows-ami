$region = "us-west-2"
Read-S3Object -BucketName "d-manthan-poc-provisioning-sandbox-bucket" -KeyPrefix "Packer" -Folder "C:\temp\S3Downloads" -region $region -Verbose

# Place an installer or setup file for some software in your bucket and then reference it here.
# The Read-S3Object line above will download it during Packer image build and place it in C:\temp\S3Downloads. Next, the installer can be run in the image build

#$pathvargs = {C:\temp\S3Downloads\WFBS-SVC_Downloader.exe /S }
#Invoke-Command -ScriptBlock $pathvargs


set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"

#Redshift JDBC Driver Configuration
mkdir "C:\Program Files\Amazon Redshift JDBC Driver"
copy "C:\temp\S3Downloads\RedshiftJDBC42-no-awssdk-*.jar" "C:\Program Files\Amazon Redshift JDBC Driver\."
#Step for copying Python artifacts from S3 to Windows Machine
cp C:\temp\S3Downloads\pythonpkgs.zip C:\Python38\Lib\site-packages
sz x -o'C:\Python38\Lib\site-packages' 'C:\Python38\Lib\site-packages\pythonpkgs.zip' -r;
rm  C:\Python38\Lib\site-packages\pythonpkgs.zip

xcopy C:\Python38\Lib\site-packages\pythonpkgs\. C:\Python38\Lib\site-packages\ /E/H
cd C:\Python38\Lib\site-packages\
rmdir /q /s pythonpkgs

#Step for copying Python artifacts from S3 to Windows Machine
cp C:\temp\S3Downloads\anaconda3pkgs.zip C:\tools\Anaconda3\Lib\site-packages
sz x -o'C:\tools\Anaconda3\Lib\site-packages' 'C:\tools\Anaconda3\Lib\site-packages\anaconda3pkgs.zip' -r;
rm  C:\tools\Anaconda3\Lib\site-packages\anaconda3pkgs.zip

xcopy C:\tools\Anaconda3\Lib\site-packages\anaconda3pkgs\. C:\tools\Anaconda3\Lib\site-packages\ /E/H
cd C:\tools\Anaconda3\Lib\site-packages\
rmdir /q /s anaconda3pkgs

#CleanUp Artifacts Location
rmdir /q /s 
#----
#Get-S3Object -BucketName $bucket -KeyPrefix $keyPrefix -AccessKey $accessKey -SecretKey $secretKey -Region $region
#cp C:\temp\S3Downloads\sample.zip C:\ProgramData\Miniconda3\pkgs
#cp 'C:\temp\S3Downloads\sample.zip' 'C:\ProgramData\Miniconda3\pkgs'
#C:\tools\Anaconda3\pkgs
#sz x -o $zipfilePath -r ;
#C:\Python38\Lib\site-packages
#C:\tools\Anaconda3\Lib\site-packages

#C:\Python38\Lib\site-packages
#cp C:\temp\S3Downloads\packages.zip C:\tools\Anaconda3\pkgs
#sz x -o'.\Desktop\.' 'C:\temp\S3Downloads\sample.zip' -r;
#Expand-7Zip -ArchiveFileName $sourcefile -TargetPath 'c:\destinaation'
#Expand-7Zip -ArchiveFileName -SourcePath 'C:\temp\S3Downloads\sample.zip' -TargetPath '.\Desktop\.' 
#sz x -o'.\Desktop\.' 'C:\temp\S3Downloads\sample.zip' -r;