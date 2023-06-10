//
//  GameUseCase.swift
//  SukGiSiDae
//

import Foundation
import Combine
import GroupActivities

typealias Quiz = String

protocol HostUseCase {

    var quiz: AnyPublisher<Quiz, Never> { get }

    func decideWinner(_ user: User) // and start next round
    func startQuiz() // send
}

protocol PlayerUseCase {
    func sendAnswer(_ answer: String)
}

protocol GameUseCaseProtocol: HostUseCase, PlayerUseCase {
    var players: [User] { get }

    func start()
    func end()
    func configureGroupSession(_ groupSession: GroupSession<GameActivity>)
}

final class GameUseCase: GameUseCaseProtocol {
    // MARK: - Properties

    var players: [User] = []
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

    func start() {

    }

    func end() {

    }

    func decideWinner(_ user: User) {

    }

    func startQuiz() {

    }

    func sendAnswer(_ answer: String) {

    }

    func sendEmptyStateForTest() {
        if let messenger = messenger {
            Task {
                try? await messenger.send(GameState())
            }
        }
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

struct GameState: Codable {
    var tempVariable: String = "tempValue"
}

