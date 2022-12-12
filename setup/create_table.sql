CREATE TABLE users( 
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(20) UNIQUE NOT NULL,
password VARCHAR(20) NOT NULL
);

CREATE TABLE extensions( 
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
extensions_name VARCHAR(4) UNIQUE NOT NULL
);

CREATE TABLE original_data( 
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
path VARCHAR(50) UNIQUE NOT NULL,
file_name VARCHAR(50) NOT NULL,
extension_id INT UNSIGNED NOT NULL,
user_id INT UNSIGNED NOT NULL,
FOREIGN KEY(extension_id) REFERENCES extensions(id),
FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE model_types( 
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
type VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE tasks(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
task_name VARCHAR(20) UNIQUE NOT NULL
);


CREATE TABLE feature_values( 
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
objective VARCHAR(50) NOT NULL,
original_data_id INT UNSIGNED NOT NULL,
model_type_id INT UNSIGNED NOT NULL,
task_id INT UNSIGNED NOT NULL,
FOREIGN KEY(original_data_id) REFERENCES original_data(id),
FOREIGN KEY(model_type_id) REFERENCES model_types(id),
FOREIGN KEY(task_id) REFERENCES tasks(id)
);

CREATE TABLE delete_string( 
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
delete_column VARCHAR(50) NOT NULL,
feature_value_id INT UNSIGNED NOT NULL,
FOREIGN KEY(feature_value_id) REFERENCES feature_values(id)
);

CREATE TABLE replace_string(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
column_name VARCHAR(50) NOT NULL,
replace_before VARCHAR(50) NOT NULL,
replace_after VARCHAR(50) NOT NULL,
is_regex BIT(1) NOT NULL DEFAULT 1,
feature_value_id INT UNSIGNED NOT NULL,
FOREIGN KEY(feature_value_id) REFERENCES feature_values(id)
);

CREATE TABLE categorical_methods( 
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
method_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE categorical_transformation(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
column_name VARCHAR(50) NOT NULL,
before_value VARCHAR(100) NOT NULL,
after_value DECIMAL(20,14) NOT NULL,
feature_value_id INT UNSIGNED NOT NULL,
categorical_method_id INT UNSIGNED NOT NULL,
FOREIGN KEY(feature_value_id) REFERENCES feature_values(id),
FOREIGN KEY(categorical_method_id) REFERENCES categorical_methods(id)
);

CREATE TABLE missing_methods(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
method_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE missing_processing(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
column_name VARCHAR(50) NOT NULL,
missing_method_id INT UNSIGNED NOT NULL,
replace_str VARCHAR(100) NOT NULL,
feature_value_id INT UNSIGNED NOT NULL,
FOREIGN KEY(missing_method_id) REFERENCES missing_methods(id),
FOREIGN KEY(feature_value_id) REFERENCES feature_values(id)
);

CREATE TABLE delete_outliers(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
column_name VARCHAR(50) NOT NULL,
delete_value DECIMAL(20,10) NOT NULL,
feature_value_id INT UNSIGNED NOT NULL,
FOREIGN KEY(feature_value_id) REFERENCES feature_values(id)
);

CREATE TABLE standardization(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
is_standardization BIT(1) NOT NULL DEFAULT 0,
feature_value_id INT UNSIGNED NOT NULL,
FOREIGN KEY(feature_value_id) REFERENCES feature_values(id)
);

CREATE TABLE division_data(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
random_state DECIMAL(5,0) NOT NULL,
test_size DECIMAL(4,3) NOT NULL,
feature_value_id INT UNSIGNED NOT NULL,
FOREIGN KEY(feature_value_id) REFERENCES feature_values(id)
);

CREATE TABLE loss(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
function_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE machine_learning(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
loss_value DECIMAL(20,10) NOT NULL,
val_loss_value DECIMAL(20,10) NOT NULL,
loss_id INT UNSIGNED NOT NULL,
feature_value_id INT UNSIGNED NOT NULL,
FOREIGN KEY(feature_value_id) REFERENCES feature_values(id),
FOREIGN KEY(loss_id) REFERENCES loss(id)
);

CREATE TABLE models(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
path VARCHAR(50) UNIQUE NOT NULL,
extension_id INT UNSIGNED NOT NULL,
machine_learning_id INT UNSIGNED NOT NULL,
FOREIGN KEY(extension_id) REFERENCES extensions(id), 
FOREIGN KEY(machine_learning_id) REFERENCES machine_learning(id)
);

CREATE TABLE gradient_boosting_decision_tree(
model_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
learn_rate DECIMAL(21,20) NOT NULL,
max_depth DECIMAL(2,0) NOT NULL DEFAULT -1,
num_round DECIMAL(4,0) NOT NULL,
early_stopping_round DECIMAL(4,0) NOT NULL,
FOREIGN KEY(model_id) REFERENCES models(id) 
);

CREATE TABLE optimizer(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
optimizer_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE activation(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
activation_name VARCHAR(20) NOT NULL
);

CREATE TABLE neural_network(
model_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
num_layers DECIMAL(2,0) NOT NULL,
units DECIMAL(4,0) NOT NULL,
hidden_activation_id INT UNSIGNED NOT NULL,
optimizer_id INT UNSIGNED NOT NULL,
is_batchnormalization BIT(1) NOT NULL DEFAULT 0,
is_early_stopping BIT(1) NOT NULL DEFAULT 0,
min_delta DECIMAL(6,5) NOT NULL DEFAULT -1,
patience DECIMAL(4,0) NOT NULL DEFAULT -1,
is_dropout BIT(1) NOT NULL DEFAULT 0,
epoch DECIMAL(4,0) NOT NULL,
batch_size DECIMAL(4,0) NOT NULL DEFAULT 0,
learn_rate DECIMAL(21,20) NOT NULL,
output_activation_id INT UNSIGNED NOT NULL,
FOREIGN KEY(model_id) REFERENCES models(id), 
FOREIGN KEY(hidden_activation_id) REFERENCES activation(id),
FOREIGN KEY(optimizer_id) REFERENCES optimizer(id),
FOREIGN KEY(output_activation_id) REFERENCES activation(id)
);

CREATE TABLE random_forest(
model_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
random_state DECIMAL(5,0) NOT NULL,
max_depth DECIMAL(2,0) NOT NULL,
max_features DECIMAL(3,0) NOT NULL,
min_samples_split DECIMAL(2,0) NOT NULL,
n_estimators DECIMAL(3,0) NOT NULL,
FOREIGN KEY(model_id) REFERENCES models(id)
);

CREATE TABLE model_evaluations(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
model_id INT UNSIGNED NOT NULL,
MAE DECIMAL(20,10) NOT NULL DEFAULT -1,
MSE DECIMAL(20,10) NOT NULL DEFAULT -1,
RMSE DECIMAL(20,10) NOT NULL DEFAULT -1,
coefficient_of_determination DECIMAL(10,9) NOT NULL DEFAULT -1,
accuracy_score DECIMAL(10,9) NOT NULL DEFAULT -1,
precision_score DECIMAL(10,9) NOT NULL DEFAULT -1,
recall_score DECIMAL(10,9) NOT NULL DEFAULT -1,
f1_score DECIMAL(10,7) NOT NULL DEFAULT -1,
logloss DECIMAL(10,9) NOT NULL DEFAULT -1,
AUC DECIMAL(10,9) NOT NULL DEFAULT -1,
multi_class_accuracy DECIMAL(10,9) NOT NULL DEFAULT -1,
mean_f1 DECIMAL(10,7) NOT NULL DEFAULT -1,
macro_f1 DECIMAL(10,7) NOT NULL DEFAULT -1,
micro_f1 DECIMAL(10,7) NOT NULL DEFAULT -1,
multi_class_logloss DECIMAL(12,9) NOT NULL DEFAULT -1,
FOREIGN KEY(model_id) REFERENCES models(id)
);

CREATE TABLE ensemble_methods(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
method_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE ensemble_evaluations(
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
ensemble_method_id INT UNSIGNED NOT NULL,
MAE DECIMAL(20,10) NOT NULL DEFAULT -1,
MSE DECIMAL(20,10) NOT NULL DEFAULT -1,
RMSE DECIMAL(20,10) NOT NULL DEFAULT -1,
coefficient_of_determination DECIMAL(10,9) NOT NULL DEFAULT -1,
accuracy_score DECIMAL(10,9) NOT NULL DEFAULT -1,
precision_score DECIMAL(10,9) NOT NULL DEFAULT -1,
recall_score DECIMAL(10,9) NOT NULL DEFAULT -1,
f1_score DECIMAL(10,7) NOT NULL DEFAULT -1,
logloss DECIMAL(10,9) NOT NULL DEFAULT -1,
AUC DECIMAL(10,9) NOT NULL DEFAULT -1,
multi_class_accuracy DECIMAL(10,9) NOT NULL DEFAULT -1,
mean_f1 DECIMAL(10,7) NOT NULL DEFAULT -1,
macro_f1 DECIMAL(10,7) NOT NULL DEFAULT -1,
micro_f1 DECIMAL(10,7) NOT NULL DEFAULT -1,
multi_class_logloss DECIMAL(12,9) NOT NULL DEFAULT -1,
FOREIGN KEY(ensemble_method_id) REFERENCES ensemble_methods(id)
);

CREATE TABLE ensemble_compositions( 
model_id INT UNSIGNED NOT NULL,
ensemble_evaluation_id INT UNSIGNED NOT NULL,
PRIMARY KEY(ensemble_evaluation_id,model_id),
FOREIGN KEY(ensemble_evaluation_id) REFERENCES ensemble_evaluations(id), 
FOREIGN KEY(model_id) REFERENCES models(id)
);