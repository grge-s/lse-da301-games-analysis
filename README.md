# Customer Loyalty Analysis — Turtle Games

**Course:** LSE Data Analytics Online Career Accelerator — DA301: Advanced Analytics for Organisational Impact
**Analyst:** George Shaheen
**Date:** March 2024

---

## 📋 Project Overview

Turtle Games is a global game manufacturer and retailer selling books, board games, video games, and toys. This project addresses four key business questions using a customer transaction and review dataset (n=2,000):

1. How do customers accumulate loyalty points?
2. Which customer segments exist for targeted marketing?
3. How can review sentiment inform marketing campaigns?
4. Can descriptive statistics support predictive modelling of loyalty behaviour?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python (pandas, scikit-learn, statsmodels, NLTK, TextBlob) | Data wrangling, modelling, NLP |
| R (tidyverse, ggplot2, car) | Statistical validation, visualisation |
| Jupyter Notebook | Interactive analysis |
| RStudio | R-based analysis |

---

## 📊 Analysis Summary

### 1. Predictive Modelling (Python)
- Built **simple linear regression** models for loyalty point prediction using spending score, remuneration, and age as predictors
- Spending score emerged as the strongest predictor (R² > 0.7, p < 0.001)
- Validated with **decision tree regression** (scikit-learn); optimal model at `max_depth=5`

### 2. Customer Segmentation
- Applied **K-means clustering** (k=5) on remuneration × spending score
- Used Elbow method and Silhouette scores for optimal k selection
- Identified five actionable segments, including a high-income/low-spending opportunity group (~20% of customers)

### 3. Sentiment Analysis (NLP)
- Full text preprocessing pipeline: tokenisation, stopword removal, normalisation
- Used **NLTK** and **TextBlob** for polarity and subjectivity scoring
- Extracted top 20 positive/negative reviews; generated word clouds for stakeholder communication

### 4. Statistical Validation (R)
- Multiple linear regression confirming Python findings (R² > 0.75)
- VIF analysis confirming no multicollinearity (all VIF < 5)
- Residual diagnostics, Shapiro-Wilk normality test, homoscedasticity checks

---

## 📁 Repository Structure

```
lse-da301-games-analysis/
├── Shaheen_George_DA301_Assignment_Notebook.ipynb   # Python analysis
├── Shaheen_George_DA301_Assignment_Notebook.R       # R analysis
├── turtle_reviews.csv                               # Raw dataset
├── turtle_reviews_clean.csv                         # Cleaned dataset
├── turtle_reviews_for_modeling.csv                  # Modelling-ready dataset
└── README.md
```

---

## 🔑 Key Findings

- **Spending behaviour** is the primary driver of loyalty point accumulation across all modelling approaches
- **Five customer segments** identified — the most actionable being high-income/low-spending customers representing an untapped opportunity
- **Customer sentiment** is broadly positive; top pain points relate to product availability and pricing
- R and Python analyses are mutually confirmatory, strengthening confidence in recommendations

---

## ⚙️ How to Run

**Python (Jupyter Notebook):**
```bash
pip install pandas numpy scikit-learn statsmodels nltk textblob matplotlib seaborn wordcloud
jupyter notebook Shaheen_George_DA301_Assignment_Notebook.ipynb
```

**R:**
```r
install.packages(c("tidyverse", "ggplot2", "car", "moments"))
# Open Shaheen_George_DA301_Assignment_Notebook.R in RStudio
```

---

## 📜 Disclaimer

This project was completed as part of the LSE Data Analytics Online Career Accelerator. The dataset is fictional and used for educational purposes only.
