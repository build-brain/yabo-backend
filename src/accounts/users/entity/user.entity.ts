import { ApiProperty } from '@nestjs/swagger';
import { $Enums, User } from '@prisma/client';
import { Exclude } from 'class-transformer';

export class UserEntity implements User {
  constructor({ ...data }: Partial<UserEntity>) {
    Object.assign(this, data);
  }
    email: string;
    login: string;
    code: number;
    pay: number;
    isActive: boolean;

  @ApiProperty({
    description: 'Unique identifier of the user',
    example: 1,
  })
  id: number;

  @ApiProperty({
    description: "User's phone number",
    example: '+1234567890',
  })
  phone: string;

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
    description: "User's birthdate",
    type: String,
    example: '2000-01-01',
  })
  birthDate: Date;

  @ApiProperty({
    description: 'District identifier associated with the user',
    example: 101,
  })
  districtId: number;

  @ApiProperty({
    description: 'Residential address of the user',
    example: '123 Main St, Springfield',
  })
  address: string;

  @ApiProperty({
    description: "User's role in the system",
    enum: $Enums.Role,
    example: $Enums.Role.ADMIN,
  })
  role: $Enums.Role;

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
