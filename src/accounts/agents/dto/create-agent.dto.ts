import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import {
  IsDate,
  IsInt,
  IsNotEmpty,
  IsNumber,
  IsPositive,
  IsString,
  ValidateNested,
} from 'class-validator';
import { CreateUserDto } from 'src/accounts/users/dto';

export class CreateAgentDto {
  @ValidateNested()
  @Type(() => CreateUserDto)
  @ApiProperty({
    description: 'User data',
    type: CreateUserDto,
  })
  readonly userData: CreateUserDto;

  @IsNumber()
  @IsPositive()
  @ApiProperty({
    description: 'Filter of the agent',
    example: 1,
  })
  readonly filter: number;

  @IsNumber()
  @IsPositive()
  @ApiProperty({
    description: 'Code of the agent',
    example: 1,
  })
  readonly code: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'Agent address',
    example: '123 Main St',
  })
  address: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'Passport copy',
    example: '1234567890',
  })
  passportCopy: string;

  @IsDate()
  @Type(() => Date)
  @ApiProperty({
    description: 'Date of birth',
    example: '1990-01-01',
  })
  dateBirth: Date;

  @IsDate()
  @Type(() => Date)
  @ApiProperty({
    description: 'Date of first visit',
    example: '2022-01-01',
  })
  firstVisit: Date;

  @IsInt()
  @IsPositive()
  @ApiProperty({
    description: 'Audit identifier',
    example: 1,
  })
  audit: number;

  @IsInt()
  @IsPositive()
  @ApiProperty({
    description: 'Cashbox identifier',
    example: 1,
  })
  cashbox: number;

  @IsInt()
  @IsPositive()
  @ApiProperty({
    description: 'Van selling identifier',
    example: 1,
  })
  vanSelling: number;
}
