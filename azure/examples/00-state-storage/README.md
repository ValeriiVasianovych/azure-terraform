# Azure Remote State Storage

Этот пример создает Azure Storage Account для хранения Terraform state файлов.

## Настройка

### Способ 1: Переменные окружения (Рекомендуемый)
```bash
export TF_VAR_subscription_id="your-subscription-id"
terraform plan
```

### Способ 2: Файл terraform.tfvars
Создайте файл `terraform.tfvars`:
```
subscription_id = "your-subscription-id"
```

### Способ 3: Командная строка
```bash
terraform plan -var="subscription_id=your-subscription-id"
```

## Использование

1. Настройте subscription ID одним из способов выше
2. Запустите `terraform init`
3. Запустите `terraform plan` для проверки
4. Запустите `terraform apply` для создания ресурсов

## Создаваемые ресурсы

- Resource Group: `tfstate`
- Storage Account: `tfstate{random_string}`
- Storage Container: `tfstate`
