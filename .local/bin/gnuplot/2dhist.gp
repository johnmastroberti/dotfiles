if (ARGC < 3) {
  return
}

if (ARGC == 3) {
  datafile = sprintf("%s_%s_%s", ARG1, ARG2, ARG3)
} else {
  datafile = sprintf("%s_%s_%s_%s", ARG1, ARG2, ARG3, ARG4)
}
# Make sure this file exists
file_missing = system("[ -e ".datafile." ]; echo $?")
if (file_missing) {
  print "File not found: ".datafile
  return
}
set xlabel ARG3
set ylabel ARG2
set cblabel "Bin count"
plot datafile nonuniform matrix with image notitle
