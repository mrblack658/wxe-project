
import os
import subprocess

# Полные пути!
WALL_DIR = "/home/mrblack/.config/sway/wallpaper"
THUMBS_DIR = "/home/mrblack/.config/sway/wallpaper/thumbs"
MONITOR = "HDMI-A-1"

def main():
    if not os.path.exists(WALL_DIR):
        print("Папка не найдена!")
        return

    # Получаем список файлов
    files = [f for f in os.listdir(WALL_DIR) if os.path.isfile(os.path.join(WALL_DIR, f))]
    
    # Формируем список для Rofi
    # Если не работает с иконками, попробуем сначала просто текст
    menu_content = "\n".join(files)

    # Запускаем Rofi. 
    # ВАЖНО: добавил параметр -sep, чтобы четко разделить строки
    rofi_cmd = [
        "rofi", "-dmenu",
        "-i", # игнорировать регистр
        "-p", "Выбери обои",
        "-theme-str", "window { width: 500px; } listview { lines: 10; }"
    ]

    proc = subprocess.Popen(rofi_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
    stdout, _ = proc.communicate(input=menu_content)
    selection = stdout.strip()

    if selection:
        # Убиваем старье
        subprocess.run(["killall", "-9", "mpvpaper"], stderr=subprocess.DEVNULL)
        
        full_path = os.path.join(WALL_DIR, selection)
        
        # Запуск
        subprocess.Popen([
            "mpvpaper", 
            "-o", "no-audio loop --cache=no", 
            MONITOR, 
            full_path
        ])

if __name__ == "__main__":
    main()
