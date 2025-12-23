// *********************************************************************************************************
// This does NOT run here on your local machine - you need to create it as an AppScript on your drive and deploy
// The corresponding URL is hardcoded in generate_form.sh
//***********************************************************************************************************


function doGet(Req) {
  // Debugging:
  //Req=new Object();
  //Req.parameter = new Object();
  //Req.parameter.SheetID = "16nbTS5eOm5sOqQFs1TJEhsChl-4XS36kIVBUq00NiTg"; // Sheet
  // Req.parameter.ForDate = "2025-99-99_TEST";
  // END Debugging
  
  // Copy spreadsheet (it creates both form and sheet but the sheet is in the root folder for some reason so we have to move it)
  var FName = "SCW Weekly Comp " + Req.parameter.ForDate;
  var SFile = SpreadsheetApp.openById(Req.parameter.SheetID); 
  var NewS = SFile.copy(FName + " (Responses)");  
  var S = NewS.getSheets()[0];    // The actual sheet with data

  DriveApp.getFileById(NewS.getId()).moveTo(DriveApp.getFoldersByName("scw-comp").next());

  // Clear previous sheet data
  S.deleteRows(2, S.getLastRow());
    
  // Enable access
  NewS.addEditors(SFile.getEditors());
  NewS.addViewers(SFile.getViewers());
  DriveApp.getFileById(NewS.getId()).setSharing(DriveApp.Access.ANYONE_WITH_LINK, DriveApp.Permission.VIEW);
  
  // Update form
  var NewF = FormApp.openByUrl(NewS.getFormUrl());  
  DriveApp.getFileById(NewF.getId()).setName(FName);
  NewF.setTitle(FName);

  // Return the new IDs     
  return ContentService.createTextOutput("FormID=" + NewF.getPublishedUrl() + "\n" + "SheetID=" + NewS.getId());
}
