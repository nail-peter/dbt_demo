# dbt Semantic Layer Project

Dieses Projekt erstellt einen Semantic Layer in dbt, der von Tableau genutzt werden kann.

## Setup

### 1. Umgebungsvariablen konfigurieren

```bash
cp .env.example .env
# Bearbeite .env mit deinen PostgreSQL-Verbindungsdaten
```

### 2. dbt Profile konfigurieren

Das Projekt nutzt eine lokale `profiles.yml`. Alternativ kannst du die Konfiguration in `~/.dbt/profiles.yml` verschieben.

### 3. Abhängigkeiten installieren

```bash
dbt deps
```

### 4. Verbindung testen

```bash
dbt debug
```

### 5. Models ausführen

```bash
# Alle Models bauen
dbt run

# Tests ausführen
dbt test

# Dokumentation generieren
dbt docs generate
dbt docs serve
```

## Projektstruktur

```
models/
├── base/                 # Raw data transformations
│   ├── base_orders.sql
│   ├── base_customers.sql
│   ├── base_products.sql
│   └── sources.yml
├── staging/             # Data cleaning and standardization
│   ├── stg_orders.sql
│   ├── stg_customers.sql
│   └── stg_products.sql
└── marts/              # Business logic layer with semantic models
    ├── mart_sales_summary.sql
    ├── mart_customer_metrics.sql
    ├── semantic_models.yml
    └── metrics.yml
```

## Semantic Layer für Tableau

### Verfügbare Metrics

1. **Revenue Metrics**
   - Total Revenue
   - Monthly Revenue
   - Revenue Growth Rate

2. **Customer Metrics**
   - Total Customers
   - New Customers
   - Customer Lifetime Value
   - Repeat Purchase Rate

3. **Order Metrics**
   - Total Orders
   - Average Order Value
   - Orders per Customer

### Tableau Integration

1. **Tableau Desktop/Server 2023.3+** erforderlich
2. **dbt Cloud Account** mit Semantic Layer aktiviert
3. **Tableau Connector** für dbt Semantic Layer

#### Verbindung in Tableau herstellen:

1. In Tableau: "Mehr" > "dbt Semantic Layer"
2. Server URL: `https://semantic-layer.getdbt.com/api/graphql`
3. Token: Dein dbt Cloud Service Token
4. Environment ID: Deine dbt Cloud Environment ID

## Anpassungen

### Deine Tabellen einbinden

1. Bearbeite `models/base/sources.yml` - ändere die Tabellennamen zu deinen echten PostgreSQL-Tabellen
2. Aktualisiere die Base Models (`models/base/*.sql`) entsprechend deiner Tabellenstruktur
3. Passe die Staging Models an deine Datenqualitäts-Anforderungen an

### Weitere Metrics hinzufügen

Bearbeite `models/marts/metrics.yml` um zusätzliche Geschäftsmetriken zu definieren.

### Erweiterte Dimensionen

Bearbeite `models/marts/semantic_models.yml` um weitere Dimensionen für die Analyse hinzuzufügen.

## Nützliche Befehle

```bash
# Semantic Layer testen
dbt sl list metrics
dbt sl list dimensions

# Spezifische Metric abfragen
dbt sl query --metrics total_revenue --group-by order_date

# Documentation
dbt docs generate && dbt docs serve
```