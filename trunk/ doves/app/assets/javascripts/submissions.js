
$(document).ready(function() {
	$(".datep").datepicker();
});

function validateImage(inputFile) {
  var maxExceededMessage = "This file exceeds the maximum allowed file size (5 MB)";
  var extErrorMessage = "Only image files with extension: .jpg, .jpeg, .gif, .bmp or .png are allowed";
  var allowedExtension = ["jpg", "jpeg", "gif", "png", "bmp"];
 
  var extName;
  var maxFileSize = $(inputFile).data('max-file-size');
  var sizeExceeded = false;
  var extError = false;
 
  $.each(inputFile.files, function() {
    if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = this.name.split('.').pop().toLowerCase();
    if ($.inArray(extName, allowedExtension) == -1) {extError=true;};
  });
  if (sizeExceeded) {
    window.alert(maxExceededMessage);
    $(inputFile).val('');
  };
 
  if (extError) {
    window.alert(extErrorMessage);
    $(inputFile).val('');
  };
}
function validateVideo(inputFile) {
  var maxExceededMessage = "This file exceeds the maximum allowed file size (15 MB)";
  var extErrorMessage = "Only video files with extension: .mpg, .avi, .mp4, .mov, .mpeg or .wmv are allowed";
  var allowedExtension = ["mpg", "avi", "mp4", "mov", "mpeg", "wmv"];
 
  var extName;
  var maxFileSize = $(inputFile).data('max-file-size');
  var sizeExceeded = false;
  var extError = false;
 
  $.each(inputFile.files, function() {
    if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = this.name.split('.').pop().toLowerCase();
    if ($.inArray(extName, allowedExtension) == -1) {extError=true;};
  });
  if (sizeExceeded) {
    window.alert(maxExceededMessage);
    $(inputFile).val('');
  };
 
  if (extError) {
    window.alert(extErrorMessage);
    $(inputFile).val('');
  };
}
function validateAudio(inputFile) {
  var maxExceededMessage = "This file exceeds the maximum allowed file size (5 MB)";
  var extErrorMessage = "Only audio files with extension: .wav or .mp3 are allowed";
  var allowedExtension = ["wav", "mp3"];
 
  var extName;
  var maxFileSize = $(inputFile).data('max-file-size');
  var sizeExceeded = false;
  var extError = false;
 
  $.each(inputFile.files, function() {
    if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = this.name.split('.').pop().toLowerCase();
    if ($.inArray(extName, allowedExtension) == -1) {extError=true;};
  });
  if (sizeExceeded) {
    window.alert(maxExceededMessage);
    $(inputFile).val('');
  };
 
  if (extError) {
    window.alert(extErrorMessage);
    $(inputFile).val('');
  };
}

