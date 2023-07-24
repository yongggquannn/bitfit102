import 'package:flutter/material.dart';

class ExploreWorkoutPage extends StatelessWidget {
  const ExploreWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Workouts'),
      ),
      body: ListView(
        children: const [
          WorkoutCard(
            image: AssetImage("assets/trackimg.jpeg"),
            title: '300m Intervals',
            description: 'Run at a fast pace, faster than your tempo pace, for 300m. Take a short rest between each interval to recover(60-75s). Adjust the pace and rest period according to your fitness level and how you feel.\n\nFor example:\nSet 1: Run 300m at a fast pace\nRest: 1-2 minutes\nSet 2: Run 300m at a fast pace\nRest: 1-2 minutes\nSet 3: Run 300m at a fast pace',
          ),
          WorkoutCard(
            image: AssetImage("assets/trackimg.jpeg"),
            title: '400m Intervals',
            description: 'Run at a fast pace, faster than your tempo pace, for 400m. Take a short rest between each interval to recover(75-100s). Adjust the pace and rest period according to your fitness level and how you feel.\n\nFor example:\nSet 1: Run 400m at a fast pace\nRest: 1-2 minutes\nSet 2: Run 400m at a fast pace\nRest: 1-2 minutes\nSet 3: Run 400m at a fast pace',
          ),
          WorkoutCard(
            image: AssetImage("assets/trackimg.jpeg"),
            title: '800m Intervals',
            description: 'Run at a moderately challenging pace for 800m (2 laps). Take a rest between each interval to recover(1-2 minutes). Adjust the pace and rest period according to your fitness level and goals. Do not go too quickly on the first 400m but aim for good posture and relatively even 400m splits so as to not tire out'
          ),
          WorkoutCard(
            image: AssetImage("assets/trackimg.jpeg"),
            title: '1.2km Intervals',
            description: 'Run at slightly below tempo pace(10-15sec slower), include 2 to 3 minutes rest between sets and adjust pace and rest period according to fitness and feeling.\n For example -> \n Set 1: Run 1.2km at desired pace\n Rest: 2-3 minutes\n Set 2: Run 1.2km at desired pace\n Rest: 2-3 minutes\n Set 3: Run 1.2km at desired pace',
          ),
          WorkoutCard(
            image: AssetImage("assets/trackimg.jpeg"),
            title: 'Easy Run',
            description: 'An easy run is a relaxed and comfortable run performed at a conversational pace(Can be between 5.30min/km to 7.00min/km). It is a crucial component of your training routine, as it helps in active recovery, building endurance, and maintaining a base level of fitness.\n\nDuring an easy run, focus on enjoying the experience and allowing your body to recover and adapt. Pay attention to your breathing, running form, and overall comfort. You should be able to hold a conversation without much effort.\n\nRemember, the purpose of an easy run is to promote active recovery and provide a break from higher-intensity workouts. It helps to maintain consistency in your training and aids in building endurance over time. '
          ),
          WorkoutCard(
            image: AssetImage('assets/gymimg.jpeg'),
            title: 'Deadlift',
            description: 'Check your alignment; your spine should be straight from head to tailbone.\n Stand with your feet hip-width apart, toes pointing slightly outward. \n Grasp the bar with an overhand grip, hands placed slightly wider than shoulder-width apart. \n Keep the bar close to your body: Throughout the lift, maintain a tight grip on the bar and keep it in contact with your legs. ',
          ),
          WorkoutCard(
            image: AssetImage('assets/faq.jpeg'),
            title: 'FAQ: Tempo Pace',
            description: "A tempo workout is a continuous run that requires sustained effort. Instead of a light jog at an easy pace, you'll be pushing your body, getting your heart rate up and testing your stamina. You'll be running faster than your regular pace but for a shorter duration. \n A threshold pace, on the other hand, can be held steadily (albeit not too comfortably) for at least 20 minutes or up to one hour, in a race lasting that long. \n How to get your Tempo Pace? \n Measure the pace at which you can run an hour-long race. This might be your 10K race pace, or the fastest pace you can maintain for an hour. Divide the distance with your running time to get your pace. \n Credits: Nike, Runner'sWorld",
          ),
          WorkoutCard(
            image: AssetImage('assets/faq.jpeg'),
            title: 'FAQ: How to prevent injuries',
            description: "Ensure proper warm up and cool down routines \n Go easy on easy runs, don't overpush yourself \n Follow a progressive mileague building plan, start small and build up your running mileage over the weeks. This will help condition your body to take on the longer distances/harder paces",
          ),
          WorkoutCard(
            image: AssetImage('assets/faq.jpeg'),
            title: 'FAQ: Is it necessary to increase running mileage',
            description: "You'll need a mix of aerobic and anaerobic endurace when it comes to getting a good running PB. This is why interval training helps to train speed while long runs/easy runs builds up the aerobic endurace in the body",
          ),
        ],
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String description;

  const WorkoutCard({super.key, 
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: ListView(
                        children: description
                            .split('\n')
                            .map((item) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('•', style: TextStyle(fontSize: 16.0)),
                                      const SizedBox(width: 8.0),
                                      Expanded(child: Text(item)),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Card(
        child: Row(
          children: [
            Image(
              image: image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
