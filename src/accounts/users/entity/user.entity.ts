import { ApiProperty } from '@nestjs/swagger';
import { $Enums, User } from '@prisma/client';
import { Exclude } from 'class-transformer';

export class UserEntity implements User {
  constructor({ ...data }: Partial<UserEntity>) {
    Object.assign(this, data);
  }

  @ApiProperty({
    description: 'Unique identifier of the user',
    example: 1,
  })
  id: number;

  @ApiProperty({
    description: 'User login',
    example: 'user123',
  })
  login: string;

  @Exclude()
  password: string;

  @ApiProperty({
    description: 'First name of the user',
    example: 'John',
  })
  firstName: string;

  @ApiProperty({
    description: 'Last name of the user',
    example: 'Doe',
  })
  lastName: string;

  @ApiProperty({
    description: 'Middle name of the user',
    example: 'Smith',
    required: false,
  })
  middleName: string;

  @ApiProperty({
    description: 'Email address of the user',
    example: 'user@example.com',
    required: false,
  })
  email: string;

  @ApiProperty({
    description: "User's phone number",
    example: '+1234567890',
    required: false,
  })
  phone: string;

  @ApiProperty({
    description: "User's role in the system",
    enum: $Enums.Role,
    example: $Enums.Role.AGENT,
  })
  role: $Enums.Role;

  @ApiProperty({
    description: 'User code',
    example: 12345,
  })
  code: number;

  @ApiProperty({
    description: 'User pay',
    example: 1000,
  })
  pay: number;

  @ApiProperty({
    description: 'User is active',
    example: true,
  })
  isActive: boolean;

  @ApiProperty({
    description: 'Record creation timestamp',
    type: String,
    example: '2024-01-01T00:00:00.000Z',
  })
  createdAt: Date;

  @ApiProperty({
    description: 'Record last update timestamp',
    type: String,
    example: '2024-01-10T00:00:00.000Z',
  })
  updatedAt: Date;
}
