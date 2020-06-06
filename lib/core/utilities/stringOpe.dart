String getNumFrom62(String input) {
  if (input == null || input == "" || input.length < 9) return "";
  return input.substring(input.length - 9, input.length - 1);
}

List<String> getExecCodes(String listCode) {
  print("resturing $listCode");
  return listCode.split("&");
}
