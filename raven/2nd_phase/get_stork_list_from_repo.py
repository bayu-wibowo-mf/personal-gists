import os

dir_path = "../source_datasets"
entries = os.listdir(dir_path)
dirs = [entry for entry in entries if ".py" not in entry]

results = []
for dir in dirs:
    files = os.listdir(dir_path+f"/{dir}")
    for file in files:
        result = f"crow-lake-prod-mfcojp\t{dir}\t{file.split('.')[0]}"
        results.append(result)

with open(dir_path+"/list_table.txt", "w") as file:
    for line in results:
        file.write(f"{line}\n")