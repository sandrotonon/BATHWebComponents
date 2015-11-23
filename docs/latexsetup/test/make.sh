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


echo "Converting files to LaTeX"

`pandoc --standalone --template="template.tex" --chapters 1-custom-elements.md 2-test.md --output thesisneu.tex`

read -p "Press any key to continue... "
