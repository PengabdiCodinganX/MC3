//
//  SoundCoreDataService.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 23/07/23.
//

import Foundation

class SoundCoreDataService {
    private let coreDataManager: CoreDataManager = CoreDataManager()

    func getAllSounds() -> Result<[SoundModel], Error> {
        let request = Sound.fetchRequest()
        
        do {
            let data = try coreDataManager.viewContext.fetch(request).map({ data in
                SoundModel(
                    id: data.id,
                    sound: data.sound
                )
            })
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func getSound(id: UUID) -> Result<SoundModel, Error> {
        let request = Sound.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as NSUUID)
        
        do {
            guard let data = try coreDataManager.viewContext.fetch(request).first else {
                return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
            }
            
            let user = SoundModel(
                id: data.id,
                sound: data.sound
            )
            
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    func saveSound(sound: SoundModel) -> Result<SoundModel, Error> {
        let data = Sound(context: coreDataManager.viewContext)
        data.id = sound.id
        data.sound = sound.sound
        
        coreDataManager.saveContext()
        
        return .success(sound)
    }
    
    func updateSound(sound: SoundModel) -> Result<SoundModel, Error> {
        guard let id = sound.id else {
            return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sound ID not found"]))
        }
        
        let request = Sound.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as NSUUID)
        
        do {
            guard let data = try coreDataManager.viewContext.fetch(request).first else {
                return .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sound not found"]))
            }
            
            data.sound = sound.sound
            
            coreDataManager.saveContext()
            
            return .success(sound)
        } catch {
            return .failure(error)
        }
    }
}
