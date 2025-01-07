import os

dir_path = "../sparrow"
entries = os.listdir(dir_path)
files = [entry for entry in entries if os.path.isfile(os.path.join(dir_path, entry))]
yaml_files = [x for x in files if ".yaml" in x]

results = []
for file in yaml_files:
    file_path = dir_path+f"/{file}"
    print(file_path)
    with open(file_path, "r") as txt:
        lines = txt.readlines()
        for line in lines:
            line = line.strip()
            if "table" in line and "tables" not in line:
                result = f"crow-lake-prod-mfcojp\t{file.split('.')[0]}\t{line.split(' ')[-1]}"
                results.append(result)

with open(dir_path+"/list_table.txt", "w") as file:
    for line in results:
        file.write(f"{line}\n")