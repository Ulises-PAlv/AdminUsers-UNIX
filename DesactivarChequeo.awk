BEGIN {
  FS=" "
}

{
if ($1 !~ "#"){
print $1" "$2" "$3" "$4" "$5" ""0"   
}
}

