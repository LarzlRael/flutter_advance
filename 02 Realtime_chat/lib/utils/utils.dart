String toCapitalize(String world) {
  // return '${world[0].toUpperCase()${s.substring(1)} }';
  if (world.length == 0) return '';
  return '${world[0].toUpperCase()}${world.substring(1)}';
}
