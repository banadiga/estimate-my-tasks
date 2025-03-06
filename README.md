# Task Estimation CLI

This command-line tool predicts task estimation time based on task descriptions using a pre-trained machine learning model. It also includes functionality for training the model with new data.

## Prerequisites

Ensure you have Python installed (preferably Python 3.8+).

## Installation

1. Clone or download this repository.
2. Set up the virtual environment and install dependencies:

   ```sh
   ./setup-env.sh
   ```
3. Ensure you have a dataset (`tasks.csv`) for training and a trained model saved as `model.pkl` in the project directory.

## Training the Model

To train the model with a dataset (`tasks.csv`), run:

```sh
./train.sh
```

This will:
- Load the dataset from `tasks.csv`
- Train a machine learning model
- Save the trained model as `model.pkl`

## Usage

Run the following command to estimate task duration based on a given description:

```sh
./estimate.sh "<task description>"
```

Example:

```sh
./estimate.sh "Implement user authentication system"
```

## How It Works

1. The `setup-env.sh` script:
    - Creates and activates a Python virtual environment.
    - Installs dependencies from `requirements.txt`.

2. The `train.sh` script:
    - Activates the virtual environment.
    - Trains a model using `script.py` and `tasks.csv`.
    - Saves the trained model as `model.pkl`.
    - Deactivates the virtual environment.

3. The `estimate.sh` script:
    - Activates the Python virtual environment.
    - Loads the trained model (`model.pkl`).
    - Processes the given task description.
    - Outputs the estimated completion time.
    - Deactivates the virtual environment.

## Dependencies

This project requires the following Python libraries:

- pandas==2.2.3
- joblib==1.4.2
- click==8.1.8
- scikit-learn==1.6.1

## Notes

- The scripts assume that a virtual environment exists at `venv/`. Ensure you create one and install dependencies before running the scripts.

## License

This project is licensed under the MIT License.

