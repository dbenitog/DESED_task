import yaml

# dbenito January 2022
# Configuration parser for Sound Event Detection + Separation experiments

# Configuration files are in yaml format
# The goal is to read a configuration file and set default values in the
# case that there is some missing value. 

def combine_dicts(custom, default):
	combined = default
	for k,v in custom.items():
		if type(v) is not dict:
			combined[k] = v 
		else:
			combined[k] = combine_dicts(custom[k], default[k])

	return combined

def parse_config(config_yaml='./confs/default.yaml', default_yaml='./confs/default.yaml'):
	"""
	config_yaml: str, path to config file to be parsed
	default_yaml: str, path to default config file
	"""

	# Load configs to dictionaries:
	with open(config_yaml, "r") as f:
		config_dict = yaml.safe_load(f)

	with open(default_yaml, "r") as f:
		default_dict = yaml.safe_load(f)
	
	# Assign default keys if value is missing:
	config_dict = combine_dicts(config_dict, default_dict)

	return config_dict
