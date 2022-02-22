<details>
<summary>Screenshot</summary>

![Screenshot of CoMa v0.1.0](https://i.imgur.com/16f7DYT.png "Screenshot of CoMa v0.1.0")

</details>

### Installation
Download the binary executable from the [releases](https://github.com/Jinzulen/CoMa/releases/tag/v0.1.0) section and place it into your local *bin* directory.

If the *bin* directory doesn't exist in the `~/.local/` directory then simply create it there. Your local `.profile` file will already reference it from that location. You can check if it does by dumping the contents of `~/.profile`.

It should contain the following:
```
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
```

If it doesn't, then copy the above code and paste it there and then promptly reload the file using `source ~/.profile`.

### Flags
| Flag | Extended | Description
--- | --- | ---
g | get | Grab the statistics.
h | help | Shows the help dialog.
v | version | Shows the program version.

### FAQ
- Are these statistics accurate?
	- > Yes. The statistics the program pulls are issued by the Moroccan government.

- Where are the statistics pulled from?
	 > The data is pulled from a [portal](http://www.covidmaroc.ma/) operated by the Moroccan Ministry of Health.

- Is this program cross-platform?
	> The program will work on any platform where Crystal can work.

### License
This software is released as-is, for free and open-source under the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html) license.

```
Copyright 2022 Khalil G.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
