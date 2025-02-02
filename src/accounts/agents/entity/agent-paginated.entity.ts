import { ApiProperty } from '@nestjs/swagger';
import { MetaDateEntity } from 'src/common/pagination';
import { AgentEntity } from './agent.entity';

export class PaginatedAgentsEntity {
  @ApiProperty({ type: [AgentEntity] })
  data: AgentEntity[];

  @ApiProperty({ type: MetaDateEntity })
  meta: MetaDateEntity;
}
