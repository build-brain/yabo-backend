import {
  registerDecorator,
  ValidationOptions,
  ValidationArguments,
} from 'class-validator';

export function IsUsername(validationOptions?: ValidationOptions) {
  return function (object: Object, propertyName: string) {
    registerDecorator({
      name: 'isUsername',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: {
        validate(value: any, args: ValidationArguments) {
          // Define your username validation rules here
          const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/; // Example: Alphanumeric and underscores, 3-20 characters
          return typeof value === 'string' && usernameRegex.test(value);
        },
        defaultMessage(args: ValidationArguments) {
          return `${args.property} must be a valid username (3-20 characters, alphanumeric and underscores only)`;
        },
      },
    });
  };
}
