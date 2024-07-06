# from flask import Flask
import os

import pandas as pd
from flask import Flask, request, redirect, url_for, render_template, send_from_directory
from flask import flash
from sqlalchemy import create_engine
from werkzeug.utils import secure_filename

raw_folder = r'C:\Users\bunmi\PycharmProjects\data_processor\database\raw'  #
clean_folder = r'C:\Users\bunmi\PycharmProjects\data_processor\database\clean'
curated_folder = r'C:\Users\bunmi\PycharmProjects\data_processor\database\curated'

raw_path = r'C:\Users\bunmi\PycharmProjects\data_processor\database\raw'
clean_path = r'C:\Users\bunmi\PycharmProjects\data_processor\database\clean'
curate_path = r'C:\Users\bunmi\PycharmProjects\data_processor\database\curate'

ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif', 'csv', 'xls'}

app = Flask(__name__)
app.config['clean_folder'] = clean_folder
app.config['curated_folder'] = curated_folder
app.config['raw_folder'] = raw_folder
app.config['MAX_CONTENT_LENGTH'] = 16 * 1000 * 1000
app.add_url_rule(
    "/uploads/<name>", endpoint="download_file", build_only=True
)


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file')
            return redirect(request.url)
        file = request.files['file']
        # If the user does not select a file, the browser submits an
        # empty file without a filename.
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        # if file.filename == 'csv':

        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['raw_folder'], filename))
            return render_template('acknowledgement.html', name=file.filename)
    return render_template('upload.html')


@app.route('/downloads')
def list_downloads():
    # files = []
    dir1 = os.listdir(r'C:\Users\bunmi\PycharmProjects\data_processor\database\raw')
    dir2 = os.listdir(r'C:\Users\bunmi\PycharmProjects\data_processor\database\clean')
    dir3 = os.listdir(r'C:\Users\bunmi\PycharmProjects\data_processor\database\curated')
    files = dir1 + dir2 + dir3
    return render_template('downloads.html', files=files)


# @app.route('/downloads/<filename>')
# def download_file(filename):
#     return send_from_directory(r'C:\Users\bunmi\PycharmProjects\data_processor\database\raw', filename,
#                               as_attachment=True)

# raw_images = r"C:\Users\bunmi\PycharmProjects\data_processor\static\images\raw"


@app.route('/downloads/<filename>')
def download_file(filename):
    directory = clean_path if filename.startswith('cleaned_') else raw_path
    return send_from_directory(directory, filename, as_attachment=True)


@app.route('/preview/<filename>')
def preview_csv(filename):
    # filepath1 = os.path.join(raw_folder, filename)
    # filepath2 = os.path.join(clean_folder, filename)
    # filepath3 = os.path.join(curated_folder, filename)
    folders_ = [raw_folder, clean_folder, curated_folder]
    df_html_ = "<p>File not found in any folder.</p>"

    for folder_ in folders_:
        filepath_ = os.path.join(folder_, filename)
        if os.path.exists(filepath_):
            try:
                df_ = pd.read_csv(filepath_, nrows=5)
                df_html_ = df_.to_html(classes='table table-striped', index=False, border=0)
                break  # Stop the loop if file is found and loaded
            except Exception as e_:
                df_html_ = f"<p>Error loading file: {e_}</p>"
                break  # Optional: stop the loop if there's an error loading the file
    return f'''
    <h2>Preview of {filename}</h2>
    {df_html_}
    <p><a href="/downloads">Back to Downloads</a></p>
    '''


# Use df_html for display
@app.route('/images')
def list_images():
    image_folder = os.path.join(app.static_folder, 'images/raw')
    image_files = os.listdir(image_folder)
    return render_template('downloads.html', image_files=image_files)


@app.route('/clean-file', methods=['GET', 'POST'])
def clean_file():
    if request.method == 'POST':
        filename = request.form.get('filename')
        operation = request.form.get('operation')

        raw_filepath = os.path.join(raw_path, filename)
        print(raw_filepath)

        cleaned_filepath = os.path.join(clean_path, 'cleaned_' + filename)
        print(cleaned_filepath)

        # Check if file exists before proceeding
        if os.path.exists(raw_filepath):
            print("File exists")
        else:
            return "File does not exist.", 404

        df = pd.read_csv(raw_filepath)
        # print(df.head())

        # Apply selected cleaning operation
        if operation == 'remove_duplicates':

            df.drop_duplicates(inplace=True)
            print("Duplicates removed")

        elif operation == 'fill_missing_values_with_zeros':
            df = df.fillna(0)
            print("Filled missing data with zeros")

        elif operation == 'fill_missing_values_with_previous':
            df = df.bfill()
            print("Filled missing values with the previous value")

        elif operation == 'fill_missing_values_with_next':
            df = df.ffill()
            print("Filled missing values with the next value")

        elif operation == 'drop_rows_with_nan':
            df.dropna()
            print("dropped rows with nan")

        elif operation == 'drop_rows_with_all_nan':
            df.dropna(how='all')
            print("dropped rows with all nan")

        elif operation == 'drop_columns_with_nan':
            df.dropna(axis=1)
            print("Dropped columns with nan")

        elif operation == 'drop_columns_with_nan':
            df.dropna(axis=1)
            print("Dropped columns with nan")

        else:
            print("No operation was carried out")
        # Add more operations as elif blocks here

        # Save the cleaned file
        df.to_csv(cleaned_filepath, index=False)
        df_html = df.to_html(classes='table table-striped', index=False, border=0)
        return render_template('ack_clean.html')  # redirect(url_for('download_file',
        # filename='cleaned_' + filename))

    # If GET request, show form to enter the filename
    return render_template('clean.html')


@app.route('/process-file', methods=['GET', 'POST'])
def process_file():
    if request.method == 'POST':
        filename = request.form['filename']
        clean_filepath = os.path.join(clean_path, filename)
        curate_filepath = os.path.join(curate_path, 'cleaned_' + filename)

        # Check if file exists before proceeding
        if not os.path.exists(clean_filepath):
            return "File does not exist.", 404

        # Perform your transformations here
        df = pd.read_csv(clean_filepath)
        transformed_df = df  # This is a placeholder

        transformed_df.to_csv(curate_filepath, index=False)

        return render_template('ack_curate.html')  # redirect(url_for('download_file', filename='cleaned_' + filename))

    # If GET request, show form to enter the filename
    return render_template('curate.html')


engine = create_engine('sqlite:///datapro.db')


def insert_into_db(transformed_filepath):
    transformed_df = pd.read_csv(transformed_filepath)
    transformed_df.to_sql('your_table_name', con=engine, if_exists='append', index=False)


if __name__ == '__main__':
    app.run()

# @app.route('/uploads/<name>')
# def download_file(name):
#    return send_from_directory(app.config["UPLOAD_FOLDER"], name)
