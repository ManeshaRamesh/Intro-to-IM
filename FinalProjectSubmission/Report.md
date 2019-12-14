## Final Project Documentation

### By Manesha Ramesh and Yeji Kwon
#### Part one: project concept and description 

The project “Free the blobbies” intends to create a simple and intuitive physical interface in which users rotate a cube in real space to control the rotations of a 2D digital box. When the digital box is rotated, blobbies, a name given to the bodies created using Box2D, shake out of the digital box based on the displacement of the vertices. Using this core function, we made a game through adding three different rounds which all have a time limit of 30 seconds and a change in the size of the body of the blobbies, making it more challenging for users to displace the blobbies out of the box. The game over condition was defined by the time running out while there were still bodies remaining in the box. The user would win the game if they successfully displaced all blobbies, the number of which were kept constant throughout the rounds, for all three rounds. 

In additional to the core function of the game, we intended to use visual elements of the game to tell a narrative. The blobbies, which represent humans, start confined within the boxes. Within the boundaries of the box, they are programmed to be the identical size to each other and monotone. The boundaries are symbolic of boundaries - whether enforced  by society or personal experiences - individual set of themselves. It is only after they are removed from these confinements, they turn diverse and unique in color, size, and shape. 

![Alt Text](/images/playing.JPG)
![Alt Text](/images/playing2.JPG)


#### Part two: System Diagram of the Hardware


#### Part three: List of important Parts / Electronics

- Arduino Nano 33 BLE: 
The Accelerometer component of the arduino was used as input for the change in angles of the box. 

- Force Sensor: 
Instead of putting a button, which would bring too much attention due to the contrast on the black box, we added a black force sensor on the botton of the box which the users tapped to start and progress through the levels when they were ready to play. 

- Solderable Breadboard:
As the arduino was placed with the box, which was meant to be shaken around intensely by the user, we chose to solder the wires to make make the connection between the wires and the breadboard more stable. 


- Laser Cut Acryllic Board
To create a box which was strong enough to withhold the force and movements exerted by the user, we chose to use an acryllic instead of cardboard as the main material of the box. We also made use of the laser cutting machine in the IM Lab to print the cube precisely using a template we made online. The cube was assembled and stuck together using acryllic glue. 



- Display
For the showcase, we prioritized showcasing the visuals of the program as the interactions and movements of the boxes and the blobbies were the core components of the game. Hence, we decided it was essential to have a large display of our software. 


#### Part Four: Problems and how we handled them

- Physics of 3D Modelling on Processing

The physical interface of the game remained constant from the beginning till the end of the project. We wanted a 3D-printed box, with an accelerometer installed inside it, allowing the movements of the physical box to correspond to a movement on the screen. Initially, our intent was to display a box on the screen which moved in 3D space corresponding to the changes in x, y, z angles of the accelerometer. Inside the box, we wanted to code a spherical ball which would respond to the angular changes of the box. The ball would respond by rolling around, bouncing off the walls, all of which would occur while maintaining the integrity of the basic laws of physics. We successfully managed to program a box which moved according to the angular changes of the accelerometer. However, the physics implementation on the ball where there were two matrices influencing the ball - the main frame and the box’s frame - was beyond the technicalities and physics covered within the IM class. We decided to retreat back to 2 dimensions and better explore how we can make the ball’s movement look more natural.
- Box2d and the rotation of the black box
We understood the picture we had in our minds of the ball’s interaction with the walls of the rotating box would be involve many concepts like collision detection, gravity, acceleration, force, angular forces and so on. However, er were told that a library called Box2d happens to take care of that for us. So, we referred to Daniel Shiffman’s Nature of Code and read about how the library works and how conceptually different it is from processing.
While the tutorials and the book helped us better explore this library, we still wanted a shape in processing to be controlled by an accelerometer. After consulting with Hatim Behnsain, we discovered that the box2d object had to be destroyed and recreated for each angle and the vectors at each rotation had to be redefined. therefore , I used some vector math, to right up a function that took the original vectors of the black box, recalculated the vectors after its angular displacement. As and then the previous shape was destroyed and the new shape was generated at the positions of the calculated vectors. Once, we had figured out the mathematics using polar coordinates, vector arithmetic, the implementation was very satisfying. 
- The ball slipping out of the black box
After we had successfully implemented the accelerometer-controlled black box, we decided to put some balls inside it. However, upon moving the box, some balls would slip out. If the balls found themselves at the angular displacement of one of the corners of the box, they were able to slip out. This is because the box’s movement was not continuous, it would jump from one position to another depending on how fast the box is rotated. We wanted the ball(s) to stay inside the box. However, we also liked the dynamic and rebellious nature of the balls that were slipping out. So ,we decided to change the direction of our project to base it all on this one bug. 

#### Part Five: User Testing 

- Initially our project was supposed to be a social statement about body image. The black box represents the boundaries imposed by society. Once the blobbies escaped the black box, they would change into a different colour and shape which was supposed to be indicative of their uniqueness. The blobbies inside the balck box collected at the bottom the balck box because they were weighed down by the pressure of these beauty standards. But, once they are free, their floating movement highlighted the freedom in contrast to their previous forms. However, after some user testing, we realized people were just so invested in freeing the blobbies that they did not pay attention to these details. So we decided to gamify it and have the message embedded in the narrative of the game. However, people rarely spent time reading the text and for most bystanders I  resorted to explaining the game
- We avoided using buttons of any sort our project because we wanted to explore other kinds of interactions, That is why we used a black box. The  show was a great way to observe the different interactions. For example, we had placed a pressure sensor at the bottom of the box so that people could seamlessly move from one round to the next by tapping the bottom of the box  whenever they were ready. However, some people held the box in a way that accidentally caused the pressure sensor to activate the following rounds. We gave the interaction of the user with the box a lot of thought and did our best to keep it as minimal, invisible and intuitive as possible. Although using a pressure sensor made sense during the design of the interaction, the execution made it clear that the it was not a good idea.
Moreover, we had predicted that by observing the movement (rotational) of the box on the screen, the users would rotate the box as well. But many resorted to frantically shaking the box. Once, a user was so immersed in the game that his shaking caused the back lid to pop out and the arduino to fly out. It is not that shaking would not cause the black box to move, but rotating it would have produced more desirable results for the users. Ultimately, many people enjoyed the game and some even came back to play a few more rounds which was very encouraging. 
- The game consisted of three rounds. The third round was almost impossible to crack. Once we realized the difficulty of the third round of the game, we wrote up a scoreboard that displayed the names of those managed to win the round round (two people). That seemed to attract more people to our station. Perhaps, we had unintentionally exploited the competitive spirits of out target audience in the IM show.
- We observed that many people were confused as to what they should do. We were hoping to design the experience such that we would not have to instruct. However, some did not know what to do after they were  handed the box. Some who had experience in gaming knew to explore a bit and figure it out on their own. This was expected because the interaction itself was unconventional. However, having more guided text could have been more helpful. 
- Because the interaction depended heavily on how the box was held and moved, we realized that the characteristics and the build of the ball was also worth noting. Most interactions were aggressive and making the box sturdier would have prevented a few mishaps. Moreover, the edges of the box were a bit sharp and would sig into the palm if not careful. Perhaps, in following designs, the edges and corners should be smoothened to make the user’s interaction less painful. 
The most important thing that we discovered in this game was that there was something about the interaction in this game that made it so addictive like Flappy Bird. Some people could not take their eyes off the screen, some people played the games multiple times consecutively while others came back to our station at a later time to play our game. It was very encouraging and this kind of human computer interaction should be further studied. 
