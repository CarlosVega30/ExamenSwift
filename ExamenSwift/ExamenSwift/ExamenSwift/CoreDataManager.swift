//
//  CoreDataManager.swift
//  ExamenSwift
//
//  Created by CCDM18 on 14/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    init(){
        persistentContainer = NSPersistentContainer(name: "Empleado")
        persistentContainer.loadPersistentStores(completionHandler: {
            (descripcion, error) in
            if let error = error {
                fatalError("core data failed to inicialice \(error.localizedDescription)")
            }
        })
    }
    
    func guardarEmpleado(idEmp:String, empNombre:String, domicilio:String,
                       telefono:String, puesto:String){
        let Empleado = Empleado(context : persistentContainer.viewContext)
        Empleado.idEmp = idEmp
        Empleado.empNombre=empNombre
        Empleado.domicilio = domicilio
        Empleado.telefono = telefono
        Empleado.puesto = puesto
        
        do{
            try persistentContainer.viewContext.save()
            print("Empleado guardado")
        }
        catch{
            print("failed to  save error en \(error)")
        }
    }
    
    func leerTodosLosEmpleados()-> [Empleado]{
        let fetchRequest:NSFetchRequest<Empleado>=Empleado.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    
    func leerEmpleado(idEmp:String)->Empleado?{
        let fetchRequest:NSFetchRequest<Empleado>=Empleado.fetchRequest()
        let predicate = NSPredicate(format:"id=%@",idEmp)
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }
        catch{
            print("failed to  save error en \(error)")
        }
        return nil
        
    }
    
    func actualizaraEmpleado(empleado:Empleado){
        let fetchRequest:NSFetchRequest<Empleado>=Empleado.fetchRequest()
        let predicate = NSPredicate(format:"idEmp=%@", empleado.idEmp ?? "")
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p=datos.first
            p?.idEmp=empleado.idEmp
            p?.empNombre=empleado.empNombre
            p?.domicilio=empleado.domicilio
            p?.telefono=empleado.telefono
            p?.puesto=empleado.puesto

            try persistentContainer.viewContext.save()
            print("pedido guardado")
        }
        catch{
            print("failed to  save error en \(error)")
        }
        
    }
    
    func borrarEmpleado(empleado: Empleado){
        persistentContainer.viewContext.delete(empleado)
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
}
