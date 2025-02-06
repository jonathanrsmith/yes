// // Some of these are too specific, moreso they exist for reference.

// export function addNewValue_(sheet: GoogleAppsScript.Spreadsheet.Sheet, rid: string, newValue: string, changeColumn: string) {
//   //get needed coordinates
//   const headers = sheet.getRange("1:1").getValues()[0];
//   const change_col = headers.indexOf(changeColumn) + 1;
//   const rid_col = headers.indexOf("ID") + 1;
//   const row_num = sheet.getRange(1, rid_col, sheet.getMaxRows(), 1).getValues().map(c => c[0]).indexOf(rid) + 1;

//   //set new value to cell
//   const old = sheet.getRange(row_num, change_col).getValue();
//   sheet.getRange(row_num, change_col).setValue(newValue);
//   return { field: changeColumn, old_value: old, new_value: newValue };
// }