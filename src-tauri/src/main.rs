// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use std::process::{Command};

#[tauri::command]
fn install_packages(window: tauri::Window, packages: Vec<String>) -> Result<String, String> {
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

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![install_packages])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}   