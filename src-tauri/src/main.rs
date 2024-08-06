// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use tauri::{command, Window};
use std::process::{Command};
use std::env;

#[command]
fn install_packages(window: Window, packages: Vec<String>) -> Result<String, String> {
    if packages.is_empty() {
        return Err("Error, no packages provided for installation.".to_string());
    }

    let sudo_status = Command::new("sudo")
    .arg("-v")
    .status()
    .map_err(|e| format!("Error with sudo permissions: {}", e))?;

    if !sudo_status.success() {
        return Err("Error with sudo permissions.".to_string());
    }

    for package in packages.iter() {
        let out = Command::new("pkexec")
            .arg("pacman")
            .arg("-S")
            .arg("--noconfirm")
            .arg(&package)
            .status()
            .map_err(|e| format!("Error executing script: {}", e))?;
        
        if out.success() {
            window.emit("package-installed", package).unwrap();
        } else {
            window.emit("package-error", package).unwrap();
        }
    }

    Ok("Packages installed with 0 errors.".to_string())
}

#[command]
fn execute_script(script_name: String) -> Result<String, String> {
    let current_dir = env::current_dir().map_err(|e| e.to_string())?;
    let script_path = current_dir.join("../src/scripts").join(format!("{}.sh", script_name));
    let script_path = script_path.canonicalize().map_err(|e| e.to_string())?;

    // Ejecutar el script con bash
    let output = std::process::Command::new("bash")
        .arg(script_path)
        .output();

    match output {
        Ok(output) => {
            if output.status.success() {
                Ok(String::from_utf8_lossy(&output.stdout).to_string())
            } else {
                Err(String::from_utf8_lossy(&output.stderr).to_string())
            }
        },
        Err(e) => Err(e.to_string()),
    }
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![
            install_packages,
            execute_script
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}   