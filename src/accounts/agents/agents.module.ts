import { AgentsService } from './agents.service';
import { AgentsController } from './agents.controller';
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [AgentsController],
  providers: [AgentsService],
})
export class AgentsModule {}
