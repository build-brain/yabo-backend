import { Controller, Post, Body, Req, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthDto, RefreshTokenDto } from './dto';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { AuthEntity } from './entities';
import { JwtVerifyGuard } from '../common/guards/jwt-verify.guard';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @ApiOkResponse({ type: AuthEntity })
  @Post('login')
  async login(@Body() data: AuthDto) {
    return new AuthEntity(await this.authService.login(data));
  }

  @ApiOkResponse({ type: AuthEntity })
  @UseGuards(JwtVerifyGuard)
  @Post('refresh')
  async refresh(@Req() request, @Body() data: RefreshTokenDto) {
    const userId = request.user.sub;
    return new AuthEntity(
      await this.authService.refresh(userId, data.refreshToken),
    );
  }
}
