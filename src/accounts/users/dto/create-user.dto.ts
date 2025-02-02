import { ApiProperty, PartialType } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsDate,
  IsEmail,
  IsEnum,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsPhoneNumber,
  IsPositive,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';
import { Role } from '@prisma/client';
import { IsEntityExist } from 'src/common/validators';
import { IsUsername } from 'src/common/validators/username.validator';

export class CreateUserDto {
  @IsString()
  @IsUsername({ message: 'Login must be a valid username' })
  @IsNotEmpty()
  @ApiProperty({
    description: "The user's login or username",
    example: 'some_login',
  })
  readonly login: string;

  @IsString()
  @MinLength(6, { message: 'Password must be at least 6 characters long' })
  @IsNotEmpty()
  @ApiProperty({
    description: "The user's password (hashed)",
    example: '123qazwsx',
  })
  readonly password: string;

  @IsString()
  @MinLength(1, { message: 'First name must be at least 1 character long' })
  @MaxLength(255, { message: 'First name must not exceed 255 characters' })
  @IsNotEmpty()
  @ApiProperty({
    description: "The user's first name",
    example: 'John',
  })
  readonly firstName: string;

  @IsString()
  @MinLength(1, { message: 'Last name must be at least 1 character long' })
  @MaxLength(255, { message: 'Last name must not exceed 255 characters' })
  @IsNotEmpty()
  @ApiProperty({
    description: "The user's last name",
    example: 'Doe',
  })
  readonly lastName: string;

  @IsString()
  @MaxLength(255, { message: 'Middle name must not exceed 255 characters' })
  @IsOptional()
  @ApiProperty({
    description: "The user's middle name",
    example: 'Smith',
    required: false,
    nullable: true,
  })
  readonly middleName?: string | null;

  @IsString()
  @IsEmail({}, { message: 'Email must be a valid email address' })
  @IsOptional()
  @ApiProperty({
    description: "The user's email address",
    example: 'user@example.com',
    required: false,
    nullable: true,
  })
  readonly email: string | null;

  @IsPhoneNumber(null, { message: 'Phone number must be a valid international number' })
  @IsOptional()
  @ApiProperty({
    description: "The user's phone number",
    example: '+1234567890',
    required: false,
    nullable: true,
  })
  readonly phone?: string | null;

  @ApiProperty({
    description: "The user's code",
    example: 100,
  })
  readonly code: number;

  @ApiProperty({
    description: "The user's pay",
    example: 1000,
  })
  readonly pay: number;

  @IsEnum(Role, {
    message: 'Role must be one of the predefined enum values',
  })
  @IsNotEmpty()
  @ApiProperty({
    description: "The user's role in the system",
    enum: Role,
    example: Role.ADMIN,
  })
  readonly role: Role;
}