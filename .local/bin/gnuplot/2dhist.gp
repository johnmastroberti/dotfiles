if (ARGC < 2) {
  return
}

if (ARGC == 2) {
  datafile = sprintf("0.0_%s_%s", ARG1, ARG2)
} else {
  datafile = sprintf("0.0_%s_%s_%s", ARG1, ARG2, ARG3)
}
# Make sure this file exists
file_missing = system("[ -e ".datafile." ]; echo $?")
if (file_missing) {
  print "File not found: ".datafile
  return
}
set xlabel ARG2
set ylabel ARG1
set clabel "Bin count"
plot datafile nonuniform matrix with image notitle
