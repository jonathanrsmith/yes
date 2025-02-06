
export function getFirstFolder_(folders: GoogleAppsScript.Drive.FolderIterator) {
  let result: GoogleAppsScript.Drive.Folder | null = null;

  while (folders.hasNext()) {
    result = folders.next();
    break;
  }

  return result;
}

export function getFirstFile_(files: GoogleAppsScript.Drive.FileIterator) {
  let result: GoogleAppsScript.Drive.File | null = null;

  while (files.hasNext()) {
    result = files.next();
    break;
  }

  return result;
}