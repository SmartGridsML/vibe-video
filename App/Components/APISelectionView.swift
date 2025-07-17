//
//  APISelectionView.swift
//  
//
//  Created by Saleem, Bilal on 02/07/2025.
//

struct APISelectionView: View {
    @Binding var selectedAPI: VideoAPI
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(VideoAPI.allCases, id: \.self) { api in
                Button(action: {
                    selectedAPI = api
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: api.icon)
                            .foregroundColor(api.color)
                        
                        VStack(alignment: .leading) {
                            Text(api.displayName)
                                .font(.headline)
                            Text(api.description)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if selectedAPI == api {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.purple)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationTitle("Select AI Model")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
