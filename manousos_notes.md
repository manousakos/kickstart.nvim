# Noter

This is a note taking md file where i will keep my notes, this will need a more organising

## NVIM 

#### Keymaps
* **RENAME VARIABLE THROUGH FILE** : `<leader>rn` while cursor is on variable

## UBUNTU

#### SCREEN
* **Sent the current window in the (Up/Down/Left/Right)**:  Shift+Super+ (Up/Down/Left/Right)
* **MAXIMISE/MINIMISE WINDOW**: Super+ Up/Down


## FEDORA
* **CLI OUTPUT to CLIPBOARD**: ```<command> | wl-copy``` WORKS ON WAYLAND ONLY

## Markdown to Odt

* **Pandoc**: a tool that helps for that. Use it as is:
```bash
pandoc B2_Report.md -o ReportB2.odt \\n  --toc \\n  --number-sections 
```

## TERMINAL

#### Tree printing

* **Print a FileSystem Tree**: tree
* **Print a FileSystem Tree with X levels**: tree -L X

#### Edit Command Output directly to nvim

* **command | nvim -**

#### Terminal Color Codes:
| Color |  Code |
| Red:  |\033[91m |
| Green |  \033[92m |
| Yellow | \033[93m |
| Blue | \033[94m |
| Magenta |  \033[95m |
| Cyan | \033[96m |
| Reset |  \033[0m |

