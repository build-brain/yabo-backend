import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from 'nestjs-prisma';
import * as bcrypt from 'bcryptjs';
import { AuthEntity } from './entities';
import { ConfigService } from '@nestjs/config';
import { AuthDto } from './dto';
import { JwtPayload } from './types';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) {}

  async login(data: AuthDto): Promise<AuthEntity> {
    const user = await this.prisma.user.findUniqueOrThrow({
      where: { login: data.login },
    });

    const isPasswordValid = await bcrypt.compare(data.password, user.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid password');
    }

    const payload: JwtPayload = {
      sub: user.id,
      login: user.login,
      role: user.role,
    };

    const accessToken = await this.generateToken(
      payload,
      'JWT_ACCESS_SECRET',
      'JWT_ACCESS_EXPIRE',
    );
    const refreshToken = await this.generateToken(
      payload,
      'JWT_REFRESH_SECRET',
      'JWT_REFRESH_EXPIRE',
    );

    return {
      accessToken,
      refreshToken,
      userId: user.id,
      login: user.login,
      userRole: user.role,
    };
  }

  async refresh(userId: number, oldRefreshToken: string) {
    if (!userId) {
      throw new UnauthorizedException('Invalid user ID');
    }

    const user = await this.prisma.user.findUniqueOrThrow({
      where: {
        id: userId,
      },
    });

    try {
      const payload = await this.jwtService.verifyAsync(oldRefreshToken, {
        secret: this.configService.get<string>('JWT_REFRESH_SECRET'),
      });

      if (!payload || payload.sub !== userId) {
        throw new UnauthorizedException('Refresh token is expired or invalid');
      }
    } catch {
      throw new UnauthorizedException('Refresh token is expired or invalid');
    }

    const payload: JwtPayload = {
      sub: user.id,
      login: user.login,
      role: user.role,
    };

    const accessToken = await this.generateToken(
      payload,
      'JWT_ACCESS_SECRET',
      'JWT_ACCESS_EXPIRE',
    );
    const refreshToken = await this.generateToken(
      payload,
      'JWT_REFRESH_SECRET',
      'JWT_REFRESH_EXPIRE',
    );

    return {
      accessToken,
      refreshToken,
    };
  }

  private async generateToken(
    payload: JwtPayload,
    secretKey: string,
    expirationKey: string,
  ): Promise<string> {
    return await this.jwtService.signAsync(payload, {
      secret: this.configService.get<string>(secretKey),
      expiresIn: this.configService.get<string>(expirationKey),
    });
  }
}
