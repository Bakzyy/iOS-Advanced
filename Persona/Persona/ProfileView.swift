import SwiftUI


struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                
                Text("Бақұстар")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Student at KBTU")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: HobbiesView()) {
                    Text("My Hobbies")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: GoalsView()) {
                    Text("Мy Goals")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                Spacer()
            }
            .padding()
        }
    }
}


struct HobbiesView: View {
    let hobbies = [
        ("Фотография", "camera"),
        ("Путешествия", "airplane"),
        ("Программирование", "desktopcomputer")
    ]
    
    var body: some View {
        List(hobbies, id: \.0) { hobby in
            HStack {
                Image(systemName: hobby.1)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)

                Text(hobby.0)
                    .font(.title3)
                    .padding()
            }
        }

        .navigationTitle("Хобби")
    }
}


struct GoalsView: View {
    let goals = ["Изучить SwiftUI", "Запустить собственное приложение", "Посетить 10 новых стран"]
    
    var body: some View {
        VStack {
            ForEach(goals, id: \.self) { goal in
                Text(goal)
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Цели")
    }
}
