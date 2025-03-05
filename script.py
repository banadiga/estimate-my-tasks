import pandas as pd
import joblib
import click
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import train_test_split

# Load and preprocess data
def load_data(csv_path):
    df = pd.read_csv(csv_path)
    df = df.dropna()
    df = df[df['Custom field (Story Points)'] > 0]  # Filter out rows where estimation_time is 0
    print(df)
    return df['Summary'], df['Custom field (Story Points)']

# Train model
def train_model(csv_path, model_path):
    descriptions, estimations = load_data(csv_path)
    
    X_train, X_test, y_train, y_test = train_test_split(descriptions, estimations, test_size=0.2, random_state=42)
    
    pipeline = make_pipeline(TfidfVectorizer(), LinearRegression())
    pipeline.fit(X_train, y_train)
    
    joblib.dump(pipeline, model_path)
    print(f"Model saved to {model_path}")

# Predict estimation
def predict(model_path, description):
    model = joblib.load(model_path)
    estimation = model.predict([description])[0]
    print(f"Estimated time: {estimation:.0f}")

# CLI commands
@click.group()
def cli():
    pass

@click.command()
@click.argument('csv_path')
@click.argument('model_path')
def train(csv_path, model_path):
    "Train the estimation model."
    train_model(csv_path, model_path)

@click.command()
@click.argument('model_path')
@click.argument('description')
def estimate(model_path, description):
    "Predict estimation for a given task description."
    predict(model_path, description)

cli.add_command(train)
cli.add_command(estimate)

if __name__ == "__main__":
    cli()
