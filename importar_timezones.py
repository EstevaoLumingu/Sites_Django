import pytz
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Estevao12",
    database="mysql"
)

cursor = conn.cursor()

timezones = pytz.all_timezones
timezone_sql = "INSERT IGNORE INTO time_zone_name (Name, Time_zone_id) VALUES (%s, %s)"

for idx, tz in enumerate(timezones, start=1000):  # Começando em 1000 para evitar colisões
    cursor.execute(timezone_sql, (tz, idx))

conn.commit()
cursor.close()
conn.close()

print("Timezones adicionados com sucesso.")
