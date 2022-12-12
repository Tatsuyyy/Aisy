SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE users;
DROP TABLE extensions;
DROP TABLE original_data;
DROP TABLE model_types;
DROP TABLE tasks;
DROP TABLE feature_values;
DROP TABLE delete_string;
DROP TABLE replace_string;
DROP TABLE categorical_methods;
DROP TABLE categorical_transformation;
DROP TABLE missing_methods;
DROP TABLE missing_processing;
DROP TABLE delete_outliers;
DROP TABLE standardization;
DROP TABLE division_data;
DROP TABLE loss;
DROP TABLE machine_learning;
DROP TABLE models;
DROP TABLE gradient_boosting_decision_tree;
DROP TABLE random_forest;
DROP TABLE optimizer;
DROP TABLE activation;
DROP TABLE neural_network;
DROP TABLE model_evaluations;
DROP TABLE ensemble_methods;
DROP TABLE ensemble_evaluations;
DROP TABLE ensemble_compositions;

DROP TABLE auth_group;
DROP TABLE auth_group_permissions;
DROP TABLE auth_permission;
DROP TABLE auth_user;
DROP TABLE auth_user_groups;
DROP TABLE auth_user_user_permissions;
DROP TABLE django_admin_log;
DROP TABLE django_content_type;
DROP TABLE django_migrations;
DROP TABLE django_session;

DROP VIEW models_by_user;
DROP VIEW learn_plan;
DROP VIEW done_delete_string;
DROP VIEW done_replace_string;
DROP VIEW done_categorical;
DROP VIEW done_missing;
DROP VIEW model_info;

SET FOREIGN_KEY_CHECKS = 1;

