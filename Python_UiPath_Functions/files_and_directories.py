import os
import shutil

def create_directory(filePath):
    try:
        os.mkdir(filePath, mode = 0o666)
        blnComplete = True
    except:
        blnComplete = False
    return blnComplete

def copy_dir_files(fileOriginPath, fileNewPath):
    try: 
        files = os.listdir(fileOriginPath)
        for file_name in files:
            shutil.copy(fileOriginPath+file_name, fileNewPath+file_name)
        blnComplete = True
    except:
        blnComplete = False
    return blnComplete

def copy_file(fileOriginPath, fileNewPath):
    try:
        shutil.copy(fileOriginPath, fileNewPath)
        blnComplete = True
    except:
        blnComplete = False
    return blnComplete

def delete_file(filePath):
    try:    
        os.remove(filePath)
        blnComplete = True
    except:
        blnComplete = False
    return blnComplete    

def delete_empty_dir(dirPath):
    try:    
        os.rmdir(dirPath)
        blnComplete = True
    except:
        blnComplete = False
    return blnComplete

