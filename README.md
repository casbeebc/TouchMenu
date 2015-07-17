# TouchMenu

### A Touch Menu Component for iOS

![/TouchMenu/TouchMenu.gif](/TouchMenu/TouchMenu.gif)

## Usage

```
let touchMenuItems = [
TouchMenuItem(label: "Add", subItems: []),
TouchMenuItem(label: "Delete", subItems: []),
TouchMenuItem(label: "Edit", subItems: []),
TouchMenuItem(label: "Help", subItems: [])
]

touchMenu = TouchMenu(viewController: self, view: view, touchMenuItems: touchMenuItems)

touchMenu.touchMenuDelegate = self
```

Once the user has hovered over a menu item, this function is called in your `ViewController`:

```
func menuItemSelected(menu: TouchMenu, menuItem: TouchMenuItem) {
    // handle the menu selection
}
```

