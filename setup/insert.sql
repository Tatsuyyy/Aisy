INSERT INTO users(username, password) VALUES('tkutose', 'admin');

INSERT INTO extensions(extensions_name) VALUES('csv');
INSERT INTO extensions(extensions_name) VALUES('h5');
INSERT INTO extensions(extensions_name) VALUES('pkl');

INSERT INTO model_types(type) VALUES('NN');
INSERT INTO model_types(type) VALUES('GBDT');
INSERT INTO model_types(type) VALUES('RF');

INSERT INTO tasks(task_name) VALUES('binary');
INSERT INTO tasks(task_name) VALUES('regression');
INSERT INTO tasks(task_name) VALUES('multiclass');

INSERT INTO missing_methods(method_name) VALUES('mean');
INSERT INTO missing_methods(method_name) VALUES('median');
INSERT INTO missing_methods(method_name) VALUES('mode');

INSERT INTO categorical_methods(method_name) VALUES ('label-encoding');

INSERT INTO loss(function_name) VALUES('binary_crossentropy');
INSERT INTO loss(function_name) VALUES('mse');
INSERT INTO loss(function_name) VALUES('categorical_crossentropy');
INSERT INTO loss(function_name) VALUES('binary_logloss');
INSERT INTO loss(function_name) VALUES('rmse');
INSERT INTO loss(function_name) VALUES('multi_logloss');

INSERT INTO optimizer(optimizer_name) VALUES('Adam');

INSERT INTO activation(activation_name) VALUES('relu');
INSERT INTO activation(activation_name) VALUES('softmax');
INSERT INTO activation(activation_name) VALUES('sigmoid');
INSERT INTO activation(activation_name) VALUES('linear');

INSERT INTO ensemble_methods(method_name) VALUES('mean');
