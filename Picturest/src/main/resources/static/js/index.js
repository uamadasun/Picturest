/**
 * 
 */
 
 function hiddenUploadForm(elem){
    document.querySelector('.url-upload').style.display = "none";
}


function showUrlUpload(elem){
    document.querySelector('.upload-choose').style.display = "none";
    document.querySelector('.url-upload').style.display = "block";
}