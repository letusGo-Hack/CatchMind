//
//  GameUseCase.swift
//  SukGiSiDae
//

import Foundation
import Combine
import GroupActivities

typealias Quiz = String

protocol GameStateOwner {
    var state: AnyPublisher<GameState, Never> { get }
}

protocol HostUseCase: GameStateOwner {
    func decideWinner(_ user: User)
}

protocol PlayerUseCase: GameStateOwner {
    func sendAnswer(_ answer: String)
}

protocol GameUseCaseProtocol: HostUseCase, PlayerUseCase {
    func startSession()

    func gameStart()

    func configureGroupSession(_ groupSession: GroupSession<GameActivity>)
}

final class GameUseCase: GameUseCaseProtocol {
    // MARK: - Properties

    var players: [User] = []
    var state: AnyPublisher<GameState, Never> = Empty<GameState, Never>.init(completeImmediately: false).eraseToAnyPublisher()
    var quiz: AnyPublisher<Quiz, Never> = Empty<Quiz, Never>.init(completeImmediately: false).eraseToAnyPublisher()

    @Published private var groupSession: GroupSession<GameActivity>?
    private var messenger: GroupSessionMessenger?
    private var journal: GroupSessionJournal?

    private var cancelBag: Set<AnyCancellable> = .init()
    private var tasks = Set<Task<Void, Never>>()

    // MARK: - Methods

    func startSession() {
        Task {
            do {
                _ = try await GameActivity().activate()
            } catch {
                print("Failed to activate GameActivity activity: \(error)")
            }
        }
    }

    func gameStart() {

    }

    func decideWinner(_ user: User) {

    }

    func sendAnswer(_ answer: String) {

    }

    func configureGroupSession(_ groupSession: GroupSession<GameActivity>) {
        self.groupSession = groupSession

        let messenger = GroupSessionMessenger(session: groupSession)
        self.messenger = messenger

        let journal = GroupSessionJournal(session: groupSession)
        self.journal = journal

        groupSession.$state
            .sink { [weak self] state in
                guard let self = self else { return }
                if case .invalidated = state {
                    self.groupSession = nil
                    self.reset()
                }
            }
            .store(in: &cancelBag)

        groupSession.$activeParticipants
            .sink { activeParticipants in
                let newParticipants = activeParticipants.subtracting(groupSession.activeParticipants)

                Task {
                    print("new participants")
                    try? await messenger.send(GameState(), to: .only(newParticipants), completion: { (error) in })
                }
            }
            .store(in: &cancelBag)

        var task = Task {
            for await (state, _) in messenger.messages(of: GameState.self) {
                handleGameState(state)
            }
        }
        tasks.insert(task)

        groupSession.join()
    }

    private func reset() {

    }

    private func handleGameState(_ state: GameState) {
        print("state updated! : \(state)")
    }

//    private func handleNewParticipant(_ newParticipants: Set<Participant>) async throws {
//        Task {
//            try? await messenger?.send(GameState(), to: .only(newParticipants), completion: { (error) in
//            })
//        }
//    }
}
