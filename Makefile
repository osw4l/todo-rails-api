migrate:
	rails db:migrate

docs:
	rake rswag:specs:swaggerize

migration:
	rails generate migration AddCompletedDateTimeInTodos

scaffold_controller:
	rails generate scaffold_controller ModelName --api --skip-template-engine --no-helper --no-assets

scaffold_model:
	rails generate scaffold ModelName title:string description:text completed:boolean user:references --api

scaffold_model_fk:
	rails generate model ModelName title:string description:string completed:boolean user:references
