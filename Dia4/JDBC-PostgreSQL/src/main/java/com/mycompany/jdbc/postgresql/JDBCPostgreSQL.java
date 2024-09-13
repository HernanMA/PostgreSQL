/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.jdbc.postgresql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.*;
import java.util.Scanner;

/**
 *
 * @author hernan
 */
public class JDBCPostgreSQL {

    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/HernanMe";
        String user = "postgres"; 
        String password = "1101685607";      

        try (Connection conn = DriverManager.getConnection(url, user, password);
             Scanner scanner = new Scanner(System.in)) {

            System.out.println("Seleccione una opción:");
            System.out.println("1. Listar Vehículos Disponibles");
            System.out.println("2. Clientes con Compras Recientes");
            System.out.println("3. Historial de Servicios por Vehículo");
            System.out.println("4. Proveedores de Piezas Utilizados");
            System.out.println("5. Rendimiento del Personal de Ventas");
            System.out.println("6. Servicios Realizados por un Empleado");
            System.out.println("7. Clientes Potenciales y Vehículos de Interés");
            System.out.println("8. Empleados del Departamento de Servicio");
            System.out.println("9. Vehículos Vendidos en un Rango de Precios");
            System.out.println("10. Clientes con Múltiples Compras");

            int opcion = scanner.nextInt();
            String query = "";
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            switch (opcion) {
                case 1:
                    query = "SELECT marca, modelo, año, precio " +
                            "FROM vehiculos " +
                            "WHERE id_vehiculo NOT IN (SELECT id_vehiculo FROM ventas)";
                    break;
                case 2:
                    query = "SELECT c.nombre AS cliente, v.marca, v.modelo, ve.fecha_venta, ve.precio_final " +
                            "FROM ventas ve " +
                            "JOIN clientes c ON ve.id_cliente = c.id_cliente " +
                            "JOIN vehiculos v ON ve.id_vehiculo = v.id_vehiculo " +
                            "WHERE ve.fecha_venta >= CURRENT_DATE - INTERVAL '1 day'";
                    break;
                case 3:
                    System.out.print("Ingrese el ID del vehículo: ");
                    String idVehiculo = scanner.next();
                    query = "SELECT s.fecha_servicio, s.descripcion, s.costo, e.nombre AS empleado " +
                            "FROM servicios s " +
                            "JOIN empleados e ON s.id_empleado = e.id_empleado " +
                            "WHERE s.id_vehiculo = ? " +
                            "ORDER BY s.fecha_servicio DESC";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, idVehiculo);
                    break;
                case 4:
                    query = "SELECT DISTINCT p.nombre " +
                            "FROM proveedores p " +
                            "JOIN piezas pi ON p.id_proveedor = pi.id_proveedor " +
                            "JOIN vehiculos v ON pi.id_vehiculo = v.id_vehiculo";
                    break;
                case 5:
                    query = "SELECT e.nombre, COUNT(v.id_venta) AS num_ventas " +
                            "FROM empleados e " +
                            "JOIN ventas v ON e.id_empleado = v.id_empleado " +
                            "GROUP BY e.nombre";
                    break;
                case 6:
                    System.out.print("Ingrese el ID del empleado: ");
                    String idEmpleado = scanner.next();
                    query = "SELECT s.fecha_servicio, s.descripcion, v.marca, v.modelo, v.año " +
                            "FROM servicios s " +
                            "JOIN vehiculos v ON s.id_vehiculo = v.id_vehiculo " +
                            "WHERE s.id_empleado = ? " +
                            "ORDER BY s.fecha_servicio DESC";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, idEmpleado);
                    break;
                case 7:
                    query = "SELECT c.nombre, c.telefono, c.email, v.marca, v.modelo, v.precio " +
                            "FROM clientes c " +
                            "JOIN vehiculos v ON v.id_vehiculo = (SELECT id_vehiculo FROM ventas WHERE id_cliente = c.id_cliente LIMIT 1) " +
                            "WHERE c.es_potencial = TRUE";
                    break;
                case 8:
                    query = "SELECT e.nombre, e.fecha_contratacion " +
                            "FROM empleados e " +
                            "WHERE e.id_departamento = (SELECT id_departamento FROM departamentos WHERE nombre = 'Servicio')";
                    break;
                case 9:
                    query = "SELECT v.marca, v.modelo, v.precio, ve.fecha_venta, c.nombre AS cliente " +
                            "FROM ventas ve " +
                            "JOIN vehiculos v ON ve.id_vehiculo = v.id_vehiculo " +
                            "JOIN clientes c ON ve.id_cliente = c.id_cliente " +
                            "WHERE ve.precio_final BETWEEN 20000 AND 30000";
                    break;
                case 10:
                    query = "SELECT c.nombre, COUNT(ve.id_venta) AS num_compras " +
                            "FROM ventas ve " +
                            "JOIN clientes c ON ve.id_cliente = c.id_cliente " +
                            "GROUP BY c.nombre " +
                            "HAVING COUNT(ve.id_venta) > 1";
                    break;
                default:
                    System.out.println("Opción no válida.");
                    return;
            }

            if (pstmt == null) {
                pstmt = conn.prepareStatement(query);
            }

            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                // Imprimir los resultados (esto puede variar según la consulta)
                // Ejemplo para la opción 1
                if (opcion == 1) {
                    System.out.println("Marca: " + rs.getString("marca"));
                    System.out.println("Modelo: " + rs.getString("modelo"));
                    System.out.println("Año: " + rs.getInt("año"));
                    System.out.println("Precio: " + rs.getDouble("precio"));
                }
                // Agregar impresión similar para otras opciones aquí
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}