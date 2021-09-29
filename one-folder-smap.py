import os
import shutil

for root, dirs, files in os.walk('.'):  # replace the . with your starting directory
   for file in files:
      path_file = os.path.join(root,file)
      shutil.copy2(path_file,'destination_directory') # change you destination dir
