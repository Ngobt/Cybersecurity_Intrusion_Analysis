# Cybersecurity Intrusion Analysis with SQL

## 🌐 Project Overview
This project dives into the world of cybersecurity by analyzing network intrusion data using SQL. The goal was to clean, explore, and uncover patterns that help identify potential security threats. This work showcases my SQL skills and analytical thinking in a practical, real-world scenario.

## 🛠️ Technologies Used
- SQL (PostgreSQL/MySQL/SQLite)
- Data Cleaning Techniques
- Exploratory Data Analysis (EDA)

## 📊 Dataset Description
The dataset contains information related to network activity and intrusion attempts. Key attributes include:
- **Timestamp**: Date and time of network activity
- **Source IP/Port**: Origin of the network traffic
- **Destination IP/Port**: Target of the network traffic
- **Protocol**: Protocol used (e.g., TCP, UDP)
- **Intrusion Indicator**: Flags indicating possible malicious activity

## 🧹 SQL Scripts Breakdown

### 1️⃣ Data Cleaning (`Cybersecurity_Intrusion_Data_Cleaning.sql`)
- Removed null and duplicate records.
- Standardized timestamp formats.
- Corrected anomalies in IP address fields.
- Ensured protocol fields adhere to expected categories.

> **💡 Skill Highlight:** My meticulous attention to data integrity ensures a reliable foundation for analysis.

### 2️⃣ Exploratory Data Analysis (`Cybersecurity_Intrusion_Exploratory_Data_Analysis.sql`)
- Analyzed intrusion patterns over time.
- Identified common malicious IP addresses and protocols.
- Detected peak attack periods.
- Categorized intrusions based on source and destination characteristics.

> **💡 Skill Highlight:** This script reflects my analytical mindset and ability to translate raw data into actionable insights.

## 🔍 Key Insights
- **Top Protocol for Intrusions**: TCP traffic showed the highest intrusion activity.
- **Frequent Malicious IPs**: Several IP addresses repeatedly targeted the network.
- **Time-Based Attack Patterns**: Intrusions peaked during non-business hours.
- **Vulnerable Ports**: Ports 22 (SSH) and 3389 (RDP) were the most targeted.

## 🚀 How to Run the SQL Scripts

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/Cybersecurity_Intrusion_Analysis.git
    cd Cybersecurity_Intrusion_Analysis
    ```
2. Open your preferred SQL client.
3. Run the cleaning script:
    ```sql
    source Cybersecurity_Intrusion_Data_Cleaning.sql;
    ```
4. Run the analysis script:
    ```sql
    source Cybersecurity_Intrusion_Exploratory_Data_Analysis.sql;
    ```
5. Analyze the output for key insights.

## 🎯 Conclusion & Future Work
This project provided valuable insights into network intrusion patterns through SQL-based analysis. Future work could involve:
- Integrating the analysis with a real-time intrusion detection system (IDS).
- Extending analysis with machine learning models.
- Automating daily reports for network administrators.

> **🔑 Key Takeaway:** My SQL expertise and analytical skills were instrumental in transforming raw cybersecurity data into actionable insights.

