//
//  DCCourseList.swift
//  SwiftUIDemo (iOS)
//
//  Created by MacMini on 2022/9/8.
//

import SwiftUI

struct DCCourseList: View {

    @State var courses = courseData
    @State var active = false
    @State var activeIndex = -1
    var body: some View {
        ZStack {
            
            Color.black.opacity(active ? 0.5 : 0)
                .animation(.linear, value: active)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(courses.indices, id: \.self) { index in
                        
                        let acc = self.activeIndex != index && self.active
                        
                        GeometryReader { geometry in
                            CourseView(
                                course: courses[index],
                                show: $courses[index].show,
                                active: $active,
                                index: index,
                                actionIndex: $activeIndex
                            )
                            .offset(y: courses[index].show ? -geometry.frame(in: .global).minY : 0)
                            .opacity(acc ? 0 : 1)
                            .scaleEffect(acc ? 0.5 : 1)
                            .offset(x: acc ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: courses[index].show ? .infinity : screen.width - 60)
                        .zIndex(courses[index].show ? 1 : 0) // 置于z轴最上，默认是0
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0), value: active)
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear, value: true)
        }
        
    }
}

struct DCCourseList_Previews: PreviewProvider {
    static var previews: some View {
        DCCourseList()
    }
}

struct CourseView: View {
    
    var course: Course
    
    @Binding var show: Bool
    @Binding var active: Bool
    
    var index: Int
    
    @Binding var actionIndex: Int
    
    @State var activeView = CGSize.zero
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading,spacing: 30.0) {
                Text ("Take your SwiftUI app to the App Store with advancedtechniques like API data, packages and CMS.")
                Text ("About this course")
                    .font (.title) .bold()
                Text ("This course is unlike any other. We care about designand want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for i0S and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces andinteractions.")
                Text ( "Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .padding (30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                    
                    
                }
                Spacer()
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 30, x: 0, y: 20)
            .gesture(
                show ? DragGesture()
                    .onChanged { value in
                        self.activeView = value.translation
                    }
                    .onEnded { value in
                        
                        if self.activeView.height > 50 {
                            self.show = false
                            self.active = false
                            self.actionIndex = -1
                        }
                        
                        self.activeView = .zero
                    }
                : nil
            )
            .onTapGesture {
                self.show.toggle()
                self.active = self.show
                if show {
                    self.actionIndex = self.index
                }else{
                    self.actionIndex = -1
                }
            }
            
            if show {
                DCCourseDetail(course: course, show: $show, active: $active, actionIndex: $actionIndex)
                    .background(Color.white)
                    .animation(nil, value: true)
            }
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - (self.activeView.height / 1000))
//        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
//        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5,dampingFraction: 0.6,blendDuration: 0), value: show)
        .gesture(
            show ? DragGesture()
                .onChanged { value in
                    self.activeView = value.translation
                }
                .onEnded { value in
                    
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.actionIndex = -1
                    }
                    
                    self.activeView = .zero
                }
            : nil
        )
        .edgesIgnoringSafeArea(.all)
    }
}


struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "UI Design for Developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
