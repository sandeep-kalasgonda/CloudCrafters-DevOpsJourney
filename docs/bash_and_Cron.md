# Introduction to Shell/Bash Scripting and Setup and user manual

Shell scripting allows you to automate tasks and interact with the operating system through command-line instructions. Bash (Bourne Again Shell) is one of the most popular shell interpreters used on Linux and Unix systems.

---

## Why Use Shell/Bash Scripting?
1. **Automation**: Automate repetitive tasks and save time.
2. **Customization**: Customize workflows and processes.
3. **System Administration**: Perform tasks like backups, updates, and monitoring.
4. **Ease of Use**: Combine multiple commands into a single script for convenience.

---

## Basic Concepts

### 1. Shebang (`#!`)
Every script starts with a **shebang** line that tells the system which interpreter to use.
```bash
#!/bin/bash
```
This specifies that the script should be run using the Bash shell.

### 2. Making a Script Executable
1. Create a script file (e.g., `script.sh`).
2. Use `chmod` to make it executable:
   ```bash
   chmod +x script.sh
   ```
3. Run the script:
   ```bash
   ./script.sh
   ```

### 3. Variables
Assign values to variables using the `=` operator (no spaces around `=`).
```bash
#!/bin/bash
name="John Doe"
echo "Hello, $name!"
```

### 4. Comments
Use `#` to add comments in your script.
```bash
# This is a comment
```

### 5. Input and Output
- **Reading Input**:
  ```bash
  read -p "Enter your name: " user_name
  echo "Hello, $user_name!"
  ```
- **Printing Output**:
  ```bash
  echo "This is an example output."
  ```

### 6. Conditionals
Use `if`, `else`, and `elif` for conditional logic.
```bash
#!/bin/bash
num=10
if [ $num -gt 5 ]; then
  echo "$num is greater than 5"
elif [ $num -eq 5 ]; then
  echo "$num is equal to 5"
else
  echo "$num is less than 5"
fi
```

### 7. Loops
- **For Loop**:
  ```bash
  for i in 1 2 3 4 5; do
    echo "Number: $i"
  done
  ```
- **While Loop**:
  ```bash
  count=1
  while [ $count -le 5 ]; do
    echo "Count: $count"
    ((count++))
  done
  ```

### 8. Functions
Functions allow you to encapsulate reusable code.
```bash
#!/bin/bash
greet() {
  echo "Hello, $1!"
}
greet "Alice"
```

---

## Example Script: Backup Files
```bash
#!/bin/bash

# Variables
source_dir="/path/to/source"
dest_dir="/path/to/backup"

# Create backup directory if it doesn't exist
if [ ! -d "$dest_dir" ]; then
  mkdir -p "$dest_dir"
fi

# Copy files
cp -r "$source_dir"/* "$dest_dir"

# Print success message
echo "Backup completed successfully!"
```

---

## Useful Commands for Shell Scripting
- `ls`: List files and directories.
- `pwd`: Print working directory.
- `cd`: Change directory.
- `cp`: Copy files.
- `mv`: Move or rename files.
- `rm`: Remove files or directories.
- `echo`: Print text to the console.
- `read`: Take user input.

---

## Debugging Tips
- Use `set -x` to enable debugging (prints each command before execution).
- Use `set +x` to disable debugging.
  ```bash
  #!/bin/bash
  set -x
  echo "Debugging enabled"
  set +x
  echo "Debugging disabled"
  ```

---

## Setting Up Cron Jobs (Crontab)
Cron is a time-based job scheduler in Unix-like operating systems. It allows you to schedule scripts or commands to run automatically at specified intervals.

### Installing Cron
To ensure cron is installed on your system, run:
```bash
sudo apt update
sudo apt install cron
```

Enable and start the cron service:
```bash
sudo systemctl enable cron
sudo systemctl start cron
```

### Editing the Crontab File
The crontab file defines the schedule for cron jobs. Open it with:
```bash
crontab -e
```
Each line in the crontab file represents a job with the following format:
```
* * * * * /path/to/command
```
Fields:
1. Minute (0-59)
2. Hour (0-23)
3. Day of the month (1-31)
4. Month (1-12)
5. Day of the week (0-7, where 0 and 7 are Sunday)
6. Command to execute

### Example: Running a Backup Script Daily
To run a backup script (`backup.sh`) every day at 2 AM:
```bash
0 2 * * * /path/to/backup.sh
```

### Viewing Cron Jobs
To list all cron jobs for the current user:
```bash
crontab -l
```

### Removing Cron Jobs
To remove all cron jobs for the current user:
```bash
crontab -r
```

---

# Introduction to Shell/Bash Scripting

Shell scripting allows you to automate tasks and interact with the operating system through command-line instructions. Bash (Bourne Again Shell) is one of the most popular shell interpreters used on Linux and Unix systems.

---

## Why Use Shell/Bash Scripting?
1. **Automation**: Automate repetitive tasks and save time.
2. **Customization**: Customize workflows and processes.
3. **System Administration**: Perform tasks like backups, updates, and monitoring.
4. **Ease of Use**: Combine multiple commands into a single script for convenience.

---

## Basic Concepts

### 1. Shebang (`#!`)
Every script starts with a **shebang** line that tells the system which interpreter to use.
```bash
#!/bin/bash
```
This specifies that the script should be run using the Bash shell.

### 2. Making a Script Executable
1. Create a script file (e.g., `script.sh`).
2. Use `chmod` to make it executable:
   ```bash
   chmod +x script.sh
   ```
3. Run the script:
   ```bash
   ./script.sh
   ```

### 3. Variables
Assign values to variables using the `=` operator (no spaces around `=`).
```bash
#!/bin/bash
name="John Doe"
echo "Hello, $name!"
```

### 4. Comments
Use `#` to add comments in your script.
```bash
# This is a comment
```

### 5. Input and Output
- **Reading Input**:
  ```bash
  read -p "Enter your name: " user_name
  echo "Hello, $user_name!"
  ```
- **Printing Output**:
  ```bash
  echo "This is an example output."
  ```

### 6. Conditionals
Use `if`, `else`, and `elif` for conditional logic.
```bash
#!/bin/bash
num=10
if [ $num -gt 5 ]; then
  echo "$num is greater than 5"
elif [ $num -eq 5 ]; then
  echo "$num is equal to 5"
else
  echo "$num is less than 5"
fi
```

### 7. Loops
- **For Loop**:
  ```bash
  for i in 1 2 3 4 5; do
    echo "Number: $i"
  done
  ```
- **While Loop**:
  ```bash
  count=1
  while [ $count -le 5 ]; do
    echo "Count: $count"
    ((count++))
  done
  ```

### 8. Functions
Functions allow you to encapsulate reusable code.
```bash
#!/bin/bash
greet() {
  echo "Hello, $1!"
}
greet "Alice"
```

---

## Example Script: Backup Files
```bash
#!/bin/bash

# Variables
source_dir="/path/to/source"
dest_dir="/path/to/backup"

# Create backup directory if it doesn't exist
if [ ! -d "$dest_dir" ]; then
  mkdir -p "$dest_dir"
fi

# Copy files
cp -r "$source_dir"/* "$dest_dir"

# Print success message
echo "Backup completed successfully!"
```

---

## Useful Commands for Shell Scripting
- `ls`: List files and directories.
- `pwd`: Print working directory.
- `cd`: Change directory.
- `cp`: Copy files.
- `mv`: Move or rename files.
- `rm`: Remove files or directories.
- `echo`: Print text to the console.
- `read`: Take user input.

---

## Debugging Tips
- Use `set -x` to enable debugging (prints each command before execution).
- Use `set +x` to disable debugging.
  ```bash
  #!/bin/bash
  set -x
  echo "Debugging enabled"
  set +x
  echo "Debugging disabled"
  ```

---

## Setting Up Cron Jobs (Crontab)
Cron is a time-based job scheduler in Unix-like operating systems. It allows you to schedule scripts or commands to run automatically at specified intervals.

### Installing Cron
To ensure cron is installed on your system, run:
```bash
sudo apt update
sudo apt install cron
```

Enable and start the cron service:
```bash
sudo systemctl enable cron
sudo systemctl start cron
```

### Editing the Crontab File
The crontab file defines the schedule for cron jobs. Open it with:
```bash
crontab -e
```
Each line in the crontab file represents a job with the following format:
```
* * * * * /path/to/command
```
Fields:
1. Minute (0-59)
2. Hour (0-23)
3. Day of the month (1-31)
4. Month (1-12)
5. Day of the week (0-7, where 0 and 7 are Sunday)
6. Command to execute

### Example: Running a Backup Script Daily
To run a backup script (`backup.sh`) every day at 2 AM:
```bash
0 2 * * * /path/to/backup.sh
```

### Viewing Cron Jobs
To list all cron jobs for the current user:
```bash
crontab -l
```

### Removing Cron Jobs
To remove all cron jobs for the current user:
```bash
crontab -r
```

---

