import { ApiProperty } from '@nestjs/swagger';
import { $Enums, User } from '@prisma/client';
import { AgentEntity } from 'src/accounts/agents/entity';

export class UserWithExpandedAgentEntity implements User {
  constructor({ agent, ...data }: Partial<UserWithExpandedAgentEntity>) {
    Object.assign(this, data);
    if (agent) {
      this.agent = new AgentEntity(agent);
    }
  }

  @ApiProperty({
    description: 'Unique identifier of the user',
    example: 1,
  })
  id: number;

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
    description: 'User login',
    example: 'user123',
  })
  login: string;

  @ApiProperty({
    description: 'User password',
    example: 'password123',
  })
  password: string;

  @ApiProperty({
    description: 'User role',
    enum: $Enums.Role,
    example: $Enums.Role.AGENT,
  })
  role: $Enums.Role;

  @ApiProperty({
    description: 'User code',
    example: 1,
  })
  code: number;

  @ApiProperty({
    description: 'User pay',
    example: 1000,
  })
  pay: number;

  @ApiProperty({
    description: 'Agent data associated with the user',
    type: () => AgentEntity,
  })
  agent: AgentEntity;

  @ApiProperty({
    description: 'User is active',
    example: true,
  })
  isActive: boolean;

  @ApiProperty({
    description: 'User creation date',
    example: '2024-01-01T00:00:00.000Z',
  })
  createdAt: Date;

  @ApiProperty({
    description: 'User update date',
    example: '2024-01-01T00:00:00.000Z',
  })
  updatedAt: Date;
}