import pandas as pd
import joblib
import click
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import train_test_split

# Load and preprocess data
def load_data(csv_path):
    # Read the CSV file into a DataFrame
    df = pd.read_csv(csv_path)
    
    # Remove rows with missing values
    df = df.dropna()
    
    # Filter out rows where 'Custom field (Story Points)' is 0 (i.e., no estimation)
    df = df[df['Custom field (Story Points)'] > 0]
    
    # Print the DataFrame for inspection (can be removed later)
    print(df)
    
    # Return task descriptions (Summary) and corresponding story point estimates
    return df['Summary'], df['Custom field (Story Points)']

# Train model
def train_model(csv_path, model_path):
    # Load and preprocess data
    descriptions, estimations = load_data(csv_path)
    
    # Split data into training and test sets (80% train, 20% test)
    X_train, X_test, y_train, y_test = train_test_split(descriptions, estimations, test_size=0.2, random_state=42)
    
    # Create a pipeline with TF-IDF vectorization and a linear regression model
    pipeline = make_pipeline(TfidfVectorizer(), LinearRegression())
    
    # Train the model on the training data
    pipeline.fit(X_train, y_train)
    
    # Save the trained model to the specified path
    joblib.dump(pipeline, model_path)
    print(f"Model saved to {model_path}")

# Predict estimation
def predict(model_path, description):
    # Load the trained model
    model = joblib.load(model_path)
    
    # Predict the estimation for the provided task description
    estimation = model.predict([description])[0]
    
    # Print the predicted estimation (rounded to the nearest integer)
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

# Add the train and estimate commands to the CLI interface
cli.add_command(train)
cli.add_command(estimate)

# Entry point for the command-line interface
if __name__ == "__main__":
    cli()
