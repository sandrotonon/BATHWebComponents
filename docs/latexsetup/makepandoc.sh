# This script was created to convert a directory full
# of markdown files into rst equivalents. It uses
# pandoc to do the conversion.
#
# 1. Install pandoc from http://johnmacfarlane.net/pandoc/
# 2. Copy this script into the directory containing the .md files
# 3. Ensure that the script has execute permissions
# 4. Run the script
#
# By default this will keep the original .md file

BASEDIR="../release"
for dir in $(find "$BASEDIR" -mindepth 1 -maxdepth 3 -type d); do
  # echo $dir
  for file in $dir/*.md
  do
    # extension="${f##*.}"
    filename="${file%.*}"
    echo "Converting $file to $filename.tex"
    `pandoc -f markdown -t latex $file -o $filename.tex`
    # uncomment this line to delete the source file.
    # rm $file
  done
done
read -p "Press any key to continue... "
