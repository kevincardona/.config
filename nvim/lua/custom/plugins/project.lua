require('project_nvim').setup {
  detection_methods = { 'pattern' },
  patterns = { '.git', '.project', 'your_custom_marker_here' }
}

return {}
