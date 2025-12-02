# 🐧 Linux for Absolute Beginners

A practical beginner-friendly guide to Linux fundamentals with real command explanations.

---

## 📑 Table of Contents

1. Introduction to Linux  
2. Linux Directory Structure  
3. Understanding Linux Symbols  
4. Basic File & Directory Commands (with Explanation)  
5. Permissions and Ownership  
6. Shell Basics  
7. Using `vi` Editor (Beginner Friendly)  
8. Common Beginner Mistakes  
9. Helpful Tips  

---

## 1. 🐧 Introduction to Linux

Linux is an open-source operating system built around security, flexibility, and performance.  
It powers:
- Web servers
- Mobile OS (Android)
- Cloud platforms
- DevOps tools
- Enterprise systems

---

## 2. 📁 Linux Directory Structure

Everything starts from the root directory `/`.

```
/
├── bin       → System commands
├── home      → User folders
│   └── prash → Your files
├── etc       → Config files
├── var       → Logs and runtime files
├── tmp       → Temporary files
├── root      → Root user home
```

---

## 3. 🔣 Linux Symbols Explained

| Symbol | Meaning |
|--------|---------|
| `/` | Root directory |
| `~` | Your home directory |
| `$` | Normal user |
| `#` | Root (admin) user |
| `.` | Current directory |
| `..` | Parent directory |

### Example prompt:
```
prash@APPC-8SFXWL3:/mnt/c/users/Z8PMD/desktop/try/data_2$
```

Breakdown:
- `prash` → Username  
- `APPC-8SFXWL3` → Machine name  
- `/mnt/c/.../data_2` → Current directory  
- `$` → Normal user  

Root user example:
```
root@APPC-8SFXWL3:/root#
```

---

## 4. 📂 File & Directory Commands

### Show current location
```bash
pwd
```

### List files
```bash
ls
```

### Change directory
```bash
cd Documents
```
Moves into `Documents`.

```bash
cd ..
```
Moves one level up.

```bash
cd ~
```
Moves to home directory.

### Create file
```bash
touch file.txt
```
Creates an empty file.

### Create folder
```bash
mkdir data
```

### Copy file
```bash
cp file.txt backup.txt
```
- `file.txt` → source  
- `backup.txt` → destination  

```bash
cp file.txt data/
```
Copies into folder.

### Move / rename
```bash
mv file.txt newfile.txt
```
Rename file.

```bash
mv file.txt Documents/
```
Move file.

### Delete file
```bash
rm file.txt
```
Permanent delete.

### Delete folder
```bash
rm -r folder
```
Deletes folder and contents.

⚠️ Dangerous:
```
rm -rf folder/
```

---

## 5. 🔐 Permissions and Ownership

Check permissions:
```bash
ls -l
```

Example:
```
-rwxr-xr-- 1 prash users file.sh
drwxr-xr-- 2 prash users data
```

### First character meaning:
| Symbol | Meaning |
|--------|---------|
| `-` | File |
| `d` | Directory |
| `l` | Link |

Example breakdown:
```
drwxr-xr--
d   rwx   r-x   r--
|    |     |     |
|    |     |     └ Others
|    |     └ Group
|    └ Owner
└ Directory
```

Meaning:
- owner: read, write, execute
- group: read, execute
- others: read only

### Why 'x' is important for folders
- `x` lets you enter the directory
- Without `x`, you cannot open it

### Change permission
```bash
chmod 755 file.sh
```

### Change owner
```bash
sudo chown prash file.txt
```

---

## 6. 🐚 Shell Basics

Run command:
```bash
date
```

Run as admin:
```bash
sudo apt update
```

History:
```bash
history
```

---

## 7. 📝 Using vi Editor

Open file:
```bash
vi test.txt
```

Modes:
| Mode | Use |
|------|-----|
| Normal | Navigate |
| Insert | Edit |
| Command | Save/exit |

Enter insert mode:
```
i
```

Save:
```
Esc :w
```

Exit:
```
Esc :q
```

Save + exit:
```
Esc :wq
```

Exit without saving:
```
Esc :q!
```

---

## 8. ❌ Common Beginner Mistakes

| Mistake | Risk |
|----------|------|
| rm -rf / | Deletes OS |
| Using sudo blindly | Breaks system |
| Editing /etc | Misconfiguration |
| No backups | Data loss |

---

## 9. ✅ Helpful Tips

✔ Linux is case-sensitive  
✔ Use Tab for auto-complete  
✔ Check path before deleting  
✔ Avoid unknown commands  
✔ Practice in home folder  

---

🎉 **Welcome to Linux!**
