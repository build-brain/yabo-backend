import {
  registerDecorator,
  ValidationArguments,
  ValidationOptions,
} from 'class-validator';

export function IsSameDate(validationOptions?: ValidationOptions) {
  return function (object: Object, propertyName: string) {
    registerDecorator({
      name: 'isSameDate',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: {
        validate(value: any, args: ValidationArguments) {
          const startDate = (args.object as any).startDate;
          const endDate = value;

          if (!startDate || !endDate) {
            return true; // Не валидируем, если одного из значений нет
          }

          // Сравнение только даты (игнорируем время)
          const start = new Date(startDate).setHours(0, 0, 0, 0);
          const end = new Date(endDate).setHours(0, 0, 0, 0);

          return start === end;
        },
        defaultMessage() {
          return `Start date and end date must have the same date part (ignoring time).`;
        },
      },
    });
  };
}
