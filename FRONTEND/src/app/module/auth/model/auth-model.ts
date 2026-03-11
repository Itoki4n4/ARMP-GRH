export interface User {
  id: number;
  username: string;
  nom: string;
  prenom: string;
  role: string;
}
export interface LoginCredentials {
  username: string;
  password: string;
}
export interface LoginResponse {
  status: string;
  message: string;
  user: User;
}
