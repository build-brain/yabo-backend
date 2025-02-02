import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
} from '@nestjs/common';
import { CreateAgentDto } from './dto/create-agent.dto';

@Controller()
export class AgentsController {
  constructor(private readonly agentsService: AgentsService) {}

  @Post()
  async create(@Body() data: CreateAgentDto): Promise<AgentEntity> {
    return this.agentsService.create(data);
  }

  @Get()
  async findAll(): Promise<AgentEntity[]> {
    return this.agentsService.findAll();
  }

  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number): Promise<AgentEntity> {
    return this.agentsService.findOne(id);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() data: UpdateAgentDto,
  ): Promise<AgentEntity> {
    return this.agentsService.update(id, data);
  }

  @Delete(':id')
  async remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    return this.agentsService.remove(id);
  }
}
