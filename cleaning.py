# ==========================================
# FUNCIONES DE LIMPIEZA
# ==========================================


# Limpieza de porcentajes


# Limpieza de fechas


# Limpieza de coordenadas


import pandas as pd


def clean_percentage_columns(df, columns):
    """
    Convierte columnas de porcentajes con coma decimal a valores float.
    """
    df = df.copy()

    for column in columns:
        df[column] = (
            df[column]
            .str.replace(",", ".", regex=False)
            .astype(float)
        )

    return df



def clean_vut_data(malaga_city_72, malaga_city_92, malaga_exceptional):
    """
    Selecciona y homogeneiza las variables necesarias
    de los registros VUT de Málaga capital.
    """

    records = []

    # Registros con estructura de 72 campos
    for line in malaga_city_72:
        f = line.split("|")

        records.append({
            "registration_code": f[49],
            "registration_date": f[50],
            "coord_x": f[6],
            "coord_y": f[7],
            "srid": f[61]
        })

    # Registros con estructura de 92 campos
    for line in malaga_city_92:
        f = line.split("|")

        records.append({
            "registration_code": f[69],
            "registration_date": f[70],
            "coord_x": f[6],
            "coord_y": f[7],
            "srid": f[81]
        })

    # Registros excepcionales
    for line in malaga_exceptional:
        f = line.split("|")

        records.append({
            "registration_code": f[70],
            "registration_date": f[71],
            "coord_x": f[6],
            "coord_y": f[7],
            "srid": f[82]
        })

    return pd.DataFrame(records)



def clean_vut_types(df):
    """
    Convierte la fecha de registro y las coordenadas
    de las VUT a los tipos de datos adecuados.
    """
    df = df.copy()

    # Convertimos la fecha a formato fecha
    df["registration_date"] = pd.to_datetime(
        df["registration_date"],
        format="%Y%m%d",
        errors="coerce"
    )

    # Convertimos las coordenadas a valores numéricos
    for column in ["coord_x", "coord_y"]:
        df[column] = (
            df[column]
            .str.replace(",", ".", regex=False)
            .replace("", pd.NA)
            .astype(float)
        )

    return df


def clean_vut(malaga_city_72, malaga_city_92, malaga_exceptional):
    """
    Ejecuta el proceso completo de limpieza de los datos VUT.
    """
    df = clean_vut_data(
        malaga_city_72,
        malaga_city_92,
        malaga_exceptional
    )

    df = clean_vut_types(df)

    return df