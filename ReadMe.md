# Simple Keyboard Mapping

# Usage
```
./start.sh
```

# SETUP
1. Make scripts executable
```sh
chmod +x disable.sh
chmod +x enable.sh
chmod +x start.sh
```
3. run `xinput list` to get keyboard name and id.
4. Update the keyboard name id and master in `config.sh`
5. disable the 2nd keyboard input 
```sh
./disable.sh
```
6. add commands to the mapping file
7. Start the watch script
```
./start.sh
```



# xinput key
A useful tool to see the key codes of your keyboard
```
xinput --key
```


# xinput list
```sh
$ xinput list
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ SynPS/2 Synaptics TouchPad              	id=12	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Power Button                            	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
    ↳ Video Bus                               	id=8	[slave  keyboard (3)]
    ↳ Power Button                            	id=9	[slave  keyboard (3)]
    ↳ Sleep Button                            	id=10	[slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard            	id=11	[slave  keyboard (3)]
    ↳ MSI WMI hotkeys                         	id=13	[slave  keyboard (3)]
    ↳ Dell KB216 Wired Keyboard System Control	id=14	[slave  keyboard (3)]
    ↳ Dell KB216 Wired Keyboard               	id=15	[slave  keyboard (3)]
    ↳ Dell KB216 Wired Keyboard Consumer Control	id=16	[slave  keyboard (3)]
```
the device name is "Dell KB216 Wired Keyboard" this is the second keyboard

# Watching the key presses
Source : https://unix.stackexchange.com/questions/35649/second-keyboard-to-run-commands
running this script echos the key presses
```sh
xinput --test "Dell KB216 Wired Keyboard" \
  | grep --line-buffered "key press" | while read -r line; do
  echo "$line"
  if [ "$line" = "key press   24" ]; then
      echo "yay"
      # do something when 'a' is pressed
  fi
done
```

# Disable input
But the input still works as a regular keyboard which I don't want
So run this to disable the kayboard input:
```sh
$ xinput float 15
```

# Re Enable input
source : https://askubuntu.com/questions/160945/is-there-a-way-to-disable-a-laptops-internal-keyboard
xinput reattach <id#> <master#>
```sh
xinput reattach 15 3
```
Explanation: 15 is the device id 3 is master. This information is got from running `xinput list`
Which gave me the following....
`Dell KB216 Wired Keyboard               	id=15	[slave  keyboard (3)]`

Was able to disable the 2nd keyboard and still have the key codes outputed