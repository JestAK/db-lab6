import { HttpException, Injectable } from "@nestjs/common";
import { DatabaseService } from '../database/database.service';

@Injectable()
export class UserService {
  constructor(private readonly dbService: DatabaseService) {}

  async getAll(): Promise<any> {
    const sql = 'SELECT * FROM User';
    try {
      return await this.dbService.query(sql);
    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }

  async getOne(id: number): Promise<any> {
    const sql = 'SELECT * FROM User WHERE id = ?';
    try {
      const user = await this.dbService.query(sql, [id]);

      if (!user.length){
        throw new Error("No user with this ID")
      }

      return user

    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }

  async createOne(name: string, email: string, password: string): Promise<any> {
    const sql = 'INSERT INTO User (name, email, password) VALUES (?, ?, ?)';
    try {
      return await this.dbService.query(sql, [name, email, password]);
    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }

  async updateOne(id: number, fields: Partial<{ name: string; email: string; password: string, profilePicture: string, status: string }>): Promise<any> {
    const updates = Object.entries(fields)
      .filter(([_, value]) => value !== undefined)
      .map(([key, _]) => `${key} = ?`)
      .join(', ');

    const values = Object.values(fields).filter((value) => value !== undefined);

    const sql = `UPDATE User SET ${updates} WHERE id = ?`;
    return await this.dbService.query(sql, [...values, id]);
  }

  async deleteOne(id: number): Promise<any> {
    const sql = 'DELETE FROM User WHERE id = ?';
    try {
      return await this.dbService.query(sql, [id]);
    } catch (error) {
      throw new HttpException(error.message, error.getStatus ? error.getStatus() : 500);
    }
  }
}
