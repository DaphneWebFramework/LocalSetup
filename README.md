# LocalSetup

**LocalSetup** is a collection of configuration files and scripts designed to assist in developing, debugging, and testing specific types of projects, such as applications or test runners, within the **Daphne Web Framework**. Primarily intended for **Windows**, it also enables cross-platform debugging and testing through a pre-configured virtual **Ubuntu (Linux)** environment.

## 1. System Requirements

- **Windows 10** or later.
- **VSCode** (by Microsoft): For editing and debugging PHP code. The following extensions are also required:
	- **PHP Debug** (by Xdebug)
	- **PHP DocBlocker** (by Neil Brayfield)
- **XAMPP** (by Apache Friends): For running PHP, Apache, and MySQL locally.
- **Vagrant** (by HashiCorp): Manages the Ubuntu virtual machine.
- **VirtualBox** (by Oracle): The virtualization platform for running the Vagrant-managed VM. After installing VirtualBox, the **VirtualBox Extension Pack** must also be installed.

## 2. Installation

### 2.1. Integrating LocalSetup

To integrate LocalSetup into an existing project, download the LocalSetup repository as a zip file from the GitHub page. After extracting the contents, copy the necessary files and directories to the appropriate locations in your project. If a file with the same name (e.g., `launch.json`) already exists in your project, manually integrate the contents instead of overwriting the file.

Do not copy the `README.md` file, as it will conflict with the existing one in your project.

Here is the structure of LocalSetup:

```
LocalSetup
├───.vscode
│   ├───extensions.json
│   └───launch.json
├───test
│   ├───phpunit.coverage.pre-10.1.0.xml
│   ├───phpunit.coverage.xml
│   ├───phpunit.phar
│   ├───run.bat
│   └───run.sh
├───Vagrantfile
├───VagrantProvision.sh
├───VagrantStart.bat
├───VagrantDestroy.bat
└───README.md
```

The existing projects already include the necessary exclusions in their respective `.gitignore` files, so no further action is required to avoid committing LocalSetup files.

### 2.2. VSCode Configuration

Once LocalSetup files are integrated into your project, `extensions.json` will recommend the following extensions when you open the project in **VSCode**:

- **PHP Debug** (by Xdebug): For debugging PHP code.
- **PHP DocBlocker** (by Neil Brayfield): To assist in generating and maintaining PHPDoc comments for your code.

### 2.3. XAMPP Configuration

> Ensure that **XAMPP** is installed in the default directory `C:\xampp`. This is necessary for the configuration and scripts to work correctly.

After installing **XAMPP**, you'll need to configure `php.ini` for your local development environment:

**Enable the intl extension**:

Open the `php.ini` file and remove the semicolon (`;`) before `extension=intl` to activate it:

```ini
extension=intl
```

**Configure Xdebug**:

Add the following configuration at the end of `php.ini` to enable Xdebug:

```ini
[Xdebug]
zend_extension=xdebug
xdebug.mode=coverage,debug,develop
xdebug.start_with_request=yes
```

After making these changes, restart Apache from the XAMPP Control Panel to apply the new configuration.

### 2.4. Vagrant Configuration

After installing **Vagrant** and **VirtualBox** (along with the **VirtualBox Extension Pack**), follow these steps to set up the Ubuntu virtual machine:

**Provision the Ubuntu Environment**:

Run `VagrantStart.bat` to provision and start the Ubuntu environment. This will automatically install:

- Ubuntu 22.04.5
- PHP 8.1.2
- Apache 2.4.52
- PHPUnit 9.5.10
- Xdebug 3.1.2

This provisioning step is only done once. For subsequent starts, the script will simply start the VM unless it has been destroyed using `VagrantDestroy.bat`.

**Provisioning Details**:

- Apache is configured to allow `.htaccess` usage and the *rewrite module* is enabled.
- Xdebug is set up for *coverage* and *debugging*, with the `client_host` configured to the host machine's IP (`192.168.33.1`).
- A symlink is created to link the project's `source` directory to Apache's web root. You can then access the application home page by navigating to `http://192.168.33.10/source`.

## 3. Debugging

To debug your PHP code with **VSCode**, set a breakpoint in your file. Open the **Run and Debug** panel, and select **Xdebug (Windows)** or **Xdebug (Ubuntu)** from the dropdown menu. If debugging on Ubuntu, make sure the VM is running with `VagrantStart.bat`. Then start debugging with **Run** or **F5**, and trigger the breakpoint by interacting with your application.

## 4. Testing

To run tests, first navigate to the `test` directory using `cd test`, and then use the provided scripts:

- **Windows**: Use `run.bat`.
- **Ubuntu**: Use `run.sh` (make sure the Ubuntu VM is running with `VagrantStart.bat`).

Both scripts accept an optional filter argument to run specific tests. For example:

```batch
run.bat MyTestName
```

```bash
./run.sh MyTestName
```

The test scripts generate a coverage report, which can be viewed by opening `test/.coverage/index.html`.

You can set breakpoints in your test files and debug tests using the same steps described in the **Debugging** section.

> Note: The `phpunit.phar` bundled for use on Windows is version 11.4.0.

## License

LocalSetup is distributed under the Creative Commons Attribution 4.0 International License. For more information, visit [CC BY 4.0 License](https://creativecommons.org/licenses/by/4.0/).
