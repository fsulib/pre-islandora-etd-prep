/* Find Word, Delete Page */
/*
Run this script in Adobe Action Wizard

Steps to create this Action:
1.	Under File to be Processed, navigate to the folder containing the PDFs to be processed
2.	Under Tasks, add from the left-hand Choose tools to add menu:
    -Recognize Text/Recognize Text using OCR
    -More Tools/Execute JavaScript
    --Once added, click on Execute JavaScript to expand then enter this javascript into Specify Setting
3.	Save to Local Folder
    -Navigate to a folder where the processed PDFs should be saved  
*/

for (var n = 0; n < this.getPageNumWords(0); n++) {
    if (this.getPageNthWord(0, n) == "DigiNole") {
        this.deletePages(0);
        break;
    }
}


