import { ApiProperty } from '@nestjs/swagger';
import { Agent } from '@prisma/client';

export class AgentEntity implements Agent {
  @ApiProperty({
    description: 'Unique identifier of the agent',
    example: 1,
  })
  id: number;

  @ApiProperty({
    description: 'User identifier of the agent',
    example: 1,
  })
  userId: number;

  @ApiProperty({
    description: 'Filter of the agent',
    example: 1,
  })
  filter: number;

  @ApiProperty({
    description: 'Code of the agent',
    example: 1,
  })
  code: number;

  @ApiProperty({
    description: 'Address of the agent',
    example: '123 Main St',
  })
  address: string;

  @ApiProperty({
    description: 'Passport copy of the agent',
    example: '1234567890',
  })
  passportCopy: string;

  @ApiProperty({
    description: 'Date of birth of the agent',
    example: '1990-01-01',
  })
  dateBirth: Date;

  @ApiProperty({
    description: 'Date of first visit of the agent',
    example: '2022-01-01',
  })
  firstVisit: Date;

  @ApiProperty({
    description: 'Audit identifier of the agent',
    example: 1,
  })
  audit: number;

  @ApiProperty({
    description: 'Cashbox identifier of the agent',
    example: 1,
  })
  cashbox: number;

  @ApiProperty({
    description: 'Van selling identifier of the agent',
    example: 1,
  })
  vanSelling: number;
}
