class VideoUtils {
  List<List<String>> getVideosForAnxietyScore(int anxietyScore) {
    List<List<String>> videos = [];
    //  this switch-case block is based on anxiety score ranges and corresponding videos
    if (anxietyScore == 0) {
      videos = [
        [
          'https://www.youtube.com/watch?v=8JvniW8TjTA',
          '1 minute mindfulness exercise. by Cleveland Clinic'
        ],
        [
          'https://www.youtube.com/watch?v=nZP088xSDeQ',
          'Body Relaxation Visualizations for Anxiety Relief by The Relaxation Channel(Calm your anxiety in 2 minutes)'
        ]
      ];
    } else if (anxietyScore == 1) {
      videos = [
        [
          'https://www.youtube.com/watch?v=v-w-vSvi-24',
          'Mindful Breathing for Anxiety by University of California Television (UCTV)'
        ],
        [
          'https://www.youtube.com/watch?v=J0vYnzpNTZE',
          'A Short Mindfulness Exercise for Anxiety With Robert Hindman, PhD by Beck Institute for Cognitive Behavior Therapy'
        ]
      ];
    } else if (anxietyScore == 2) {
      videos = [
        [
          'https://www.youtube.com/watch?v=30VMIEmA114',
          'The 5-4-3-2-1 Method: A Grounding Exercise to Manage Anxiety by The Partnership In Education',
        ],
        [
          'https://www.youtube.com/watch?v=hKtKQ_AGxYg',
          'Quick Stress & Anxiety Reduction - Mindfulness Exercise (No Meditation Required!) by Julia Kristina Counselling',
        ],
      ];
    } else if (anxietyScore == 3) {
      videos = [
        [
          'https://www.youtube.com/watch?v=odADwWzHR24',
          'Relieve Stress & Anxiety with Simple Breathing Techniques by AskDoctorJo',
        ],
        [
          'https://www.youtube.com/watch?v=8vkYJf8DOsc',
          'Breathing Exercises To Stop A Panic Attack Now | TAKE A DEEP BREATH by TAKE A DEEP BREATH',
        ],
      ];
    } else if (anxietyScore == 4) {
      videos = [
        [
          'https://www.youtube.com/watch?v=LiUnFJ8P4gM',
          '4-7-8 Calm Breathing Exercise | 10 Minutes of Deep Relaxation | Anxiety Relief | Pranayama Exercise by Hands-On Meditation',
        ],
        [
          'https://www.youtube.com/watch?v=sJ04nsiz_M0',
          '3 Deep Breathing Exercises to Reduce Stress & Anxiety by Meghan Livingstone',
        ],
      ];
    } else if (anxietyScore == 5) {
      videos = [
        [
          'https://www.youtube.com/watch?v=eZBa63NZbbE',
          'Breathing exercise for stress and anxiety by Shout UK YouTube',
        ],
        [
          'https://www.youtube.com/watch?v=iuv5EomIA9s',
          'Breathing Practice - 10 Minute Guided Meditation by Mount Sinai Health System',
        ],
      ];
    } else if (anxietyScore == 6) {
      videos = [
        [
          'https://www.youtube.com/watch?v=Ix73CLI0Mo0',
          'Meditation for Stress by Psych Hub',
        ],
        [
          'https://www.youtube.com/watch?v=q-QITSveufg',
          'Guided Meditation to Get Rid of Stress | The Surfing Meditation by Priory',
        ],
      ];
    } else if (anxietyScore == 7) {
      videos = [
        [
          'https://www.youtube.com/watch?v=ymMRKr_p2W4',
          'Guided Meditation for Anxiety by Mind Fit | Reduce Anxiety And Stress | Mind Fit | Cure Fit by wearecult'
        ],
        [
          'https://www.youtube.com/watch?v=nZP088xSDeQ',
          'Super Fast Anti-Anxiety Relief Point! Dr. Mandell by motivationaldoc'
        ]
      ];
    } else if (anxietyScore == 8) {
      videos = [
        [
          'https://www.youtube.com/watch?v=esQxUoolQyc',
          'Relaxing Music For Stress Relief, Anxiety and Depressive States • Heal Mind, Body and Soul by Open Heart Music - Helios 4K'
        ],
        [
          'https://www.youtube.com/shorts/qFIV_9nRu4Y',
          'Anxiety heart palpitations 😬🫀 #mentalhealth #anxietyrelief by Jesse Katches'
        ]
      ];
    } else if (anxietyScore == 9) {
      videos = [
        [
          'https://www.youtube.com/watch?v=MIr3RsUWrdo',
          '20 Minute Guided Meditation for Reducing Anxiety and Stress--Clear the Clutter to Calm Down by The Mindful Movement'
        ],
        [
          'https://www.youtube.com/watch?v=xGb4fvfZpWM',
          '10 quick anxiety relief techniques by Doctor Ali Mattu'
        ]
      ];
    } else if (anxietyScore == 10) {
      videos = [
        [
          'https://www.youtube.com/watch?v=A9wwZmBGKiU',
          'Understanding Anxiety - A Psychiatrist Explains Symptoms, Medication Options and Therapy by UC Davis Health'
        ],
        [
          'https://www.youtube.com/watch?v=WGG7MGgptxE',
          'So, You\'re Having an Anxiety Attack (The Calm-Down Method for Stopping Anxiety Attacks) by Therapy in a Nutshell'
        ]
      ];
    } else if (anxietyScore == 11) {
      videos = [
        [
          'https://www.youtube.com/watch?v=MdHXlAgUe9Y',
          'The ONLY CURE for Crippling Anxiety (with @TheDrJohnDelonyShow) by The Minimalists'
        ],
        [
          'https://www.youtube.com/watch?v=AJAyxihadh4',
          'Progressive Muscle Relaxation for Anxiety & Stress Management by relax for a while'
        ]
      ];
    } else if (anxietyScore == 12) {
      videos = [
        [
          'https://www.youtube.com/watch?v=IZub-H2G4d4',
          '10 Minute Calming Progressive Muscle Relaxation to Ease Anxiety, Stress and Insomnia by Katie McLaughlin'
        ],
        [
          'https://www.youtube.com/watch?v=e353-KuHhKc',
          'Reduce Anxiety & Improve Sleep With Progressive Muscle Relaxation + Giveaway! by Bob & Brad'
        ]
      ];
    } else if (anxietyScore == 13) {
      videos = [
        [
          'https://www.youtube.com/watch?v=86HUcX8ZtAk',
          'PMR (Progressive Muscle Relaxation) to Help Release Tension, Relieve Anxiety or Insomnia by relax for a while'
        ],
        [
          'https://www.youtube.com/watch?v=kdLTOurs2lA',
          'How to reduce stress with progressive muscle relaxation by Hamilton Health Sciences'
        ]
      ];
    } else if (anxietyScore == 14) {
      videos = [
        [
          'https://www.youtube.com/watch?v=E4hJWVKHdh0',
          'Progressive Muscle Relaxation For Anxiety and Relaxation | Short Guided Mindfulness Meditation 2023'
        ],
        [
          'https://www.youtube.com/watch?v=O6GWJV8UkSo',
          'Guided Progressive Muscle Relaxation for Anxiety & Stress by Jason Stephenson'
        ],
      ];
    } else if (anxietyScore == 15) {
      videos = [
        [
          'https://www.youtube.com/watch?v=chDdgLRvV5E',
          '1.	Progressive Muscle Relaxation | Stress Reduction, Better Sleep, Pain Relief... and More. '
        ],
        [
          'https://www.youtube.com/watch?v=2IJUD-e14FY',
          'Guided Progressive Muscle Relaxation'
        ]
      ];
    } else if (anxietyScore == 16) {
      videos = [
        [
          'https://www.youtube.com/watch?v=tmvzzbcLxwA',
          'Cognitive Behavioral Therapy Essentials | CBT Tools for Stress, Anxiety and Self Esteem by Doc Snipes'
        ],
        [
          'https://www.youtube.com/watch?v=2w3ZlSeFxQU',
          'Cognitive Behavioral Therapy for Anxiety Video by PsychotherapyNet'
        ],
      ];
    } else if (anxietyScore == 17) {
      videos = [
        [
          'https://www.youtube.com/watch?v=9c_Bv_FBE-c',
          'What is CBT? | Making Sense of Cognitive Behavioural Therapy by Mind, the mental health charity'
        ],
        [
          'https://www.youtube.com/watch?v=q6aAQgXauQw',
          'What is Cognitive Behavioral Therapy? by Psych Hub'
        ]
      ];
    } else if (anxietyScore == 18) {
      videos = [
        [
          'https://www.youtube.com/watch?v=8-2WQF3SWwo',
          'LIVE Cognitive Behavioral Therapy Session by MedCircle'
        ],
        [
          'https://www.youtube.com/watch?v=BuTdBAM3rOw',
          'ASMR | Help for ANXIETY + Meditation (gentle rain 🌧️) by Sarah Lavender ASMR'
        ],
      ];
    } else if (anxietyScore == 19) {
      videos = [
        [
          'https://www.youtube.com/watch?v=LPvUZAlXxHs',
          'ASMR | CLICK THIS VIDEO FOR PANIC, ANXIETY, STRESS RELIEF ✅ by Karuna Satori ASMR'
        ],
        [
          'https://www.youtube.com/watch?v=L3hGIYl_htg',
          'ASMR for Anxiety ⛈ Calming Whispers & Guided Visualization for Sleep (Rain & Music Sounds) by Ozley ASMR'
        ]
      ];
    } else if (anxietyScore == 20) {
      videos = [
        [
          'https://www.youtube.com/watch?v=eZBa63NZbbE',
          'Breathing exercise for stress and anxiety'
        ],
        [
          'https://www.youtube.com/watch?v=MIr3RsUWrdo',
          '20 Minute Guided Meditation for Reducing Anxiety and Stress--Clear the Clutter to Calm Down'
        ],
      ];
    } else if (anxietyScore == 21) {
      videos = [
        [
          'https://www.youtube.com/watch?v=2w3ZlSeFxQU',
          'Guided Visualization for Anxiety: Finding Your Safe Place by Psychotherapy Net'
        ],
        [
          'https://www.youtube.com/watch?v=esQxUoolQyc',
          'Relaxing Music for Stress Relief, Anxiety and Depressive States • Heal Mind, Body and Soul'
        ],
      ];
    } else if (anxietyScore == 22) {
      videos = [
        [
          'https://www.youtube.com/watch?v=O-6f5wQXSu8',
          'Let Go of Overthinking: Visualization Meditation to Calm Anxiety by Headspace'
        ],
        [
          'https://www.youtube.com/watch?v=vNeRn90QjyA',
          'Nature & Light Visualization for Anxiety Relief with music'
        ],
      ];
    } else if (anxietyScore == 23) {
      videos = [
        [
          'https://www.youtube.com/watch?v=z39iodZOf00',
          'Anxiety & Stress Management with Floating Cloud Visualization by Relax with Me'
        ],
        [
          'https://www.youtube.com/watch?v=WGG7MGgptxE',
          'The Calm-Down Method for Stopping Anxiety Attacks'
        ],
      ];
    } else if (anxietyScore == 24) {
      videos = [
        [
          'https://www.youtube.com/watch?v=nZP088xSDeQ',
          'Body Relaxation Visualizations for Anxiety Relief by Dr Mandell'
        ],
        [
          'https://www.youtube.com/watch?v=td6BhfC7Xwk',
          'Visualization and Self-Hypnosis for Anxiety: Powerful Healing Technique by Michael Sealey'
        ],
      ];
    } else if (anxietyScore == 25) {
      videos = [
        [
          'https://www.youtube.com/watch?v=MdHXlAgUe9Y',
          'The ONLY CURE for Crippling Anxiety with The Dr John Delony Show'
        ],
        [
          'https://www.youtube.com/watch?v=IZub-H2G4d4',
          '10 Minute Calming Progressive Muscle Relaxation To Ease Anxiety, Stress and Insomnia by Katie McLaughlin'
        ],
      ];
    } else if (anxietyScore == 26) {
      videos = [
        [
          'https://www.youtube.com/watch?v=e353-KuHhKc',
          'Reduce Anxiety & Improve Sleep With Progressive Muscle Relaxation + Giveaway! by Bob & Brad'
        ],
        [
          'https://www.youtube.com/watch?v=86HUcX8ZtAk',
          'PMR (Progressive Muscle Relaxation) to Help Release Tension, Relieve Anxiety or Insomnia by relax for a while'
        ],
      ];
    } else if (anxietyScore == 27) {
      videos = [
        [
          'https://www.youtube.com/watch?v=kdLTOurs2lA',
          'How to reduce stress with progressive muscle relaxation by Hamilton Health Sciences'
        ],
        [
          'https://www.youtube.com/watch?v=AJAyxihadh4',
          'Progressive Muscle Relaxation for Anxiety and Sleep by The Mindfulness App'
        ],
      ];
    } else if (anxietyScore == 28) {
      videos = [
        [
          'https://www.youtube.com/watch?v=Z21Xslddz3Y&t=45s',
          'Progressive Muscle Relaxation for Beginners by TherapyDen'
        ],
        [
          'https://www.youtube.com/watch?v=O-6f5wQXSu8',
          'Progressive Muscle Relaxation: A Powerful Tool for Relaxation and Sleep by Headspace'
        ],
      ];
    } else if (anxietyScore == 29) {
      videos = [
        [
          'https://www.youtube.com/watch?v=tmvzzbcLxwA',
          'Cognitive Behavioral Therapy Essentials | CBT Tools for Stress, Anxiety and Self Esteem by Doc Snipes'
        ],
        [
          'https://www.youtube.com/watch?v=86m4RC_ADEY',
          'Cognitive Behavioral Therapy for Anxiety Video by PsychotherapyNet'
        ],
      ];
    } else if (anxietyScore == 30) {
      videos = [
        [
          'https://www.youtube.com/watch?v=9c_Bv_FBE-c',
          'What is CBT? | Making Sense of Cognitive Behavioural Therapy by Mind, the mental health charity'
        ],
        [
          'https://www.youtube.com/watch?v=86m4RC_ADEY',
          'What is Cognitive Behavioral Therapy? by Psych Hub'
        ],
      ];
    } else if (anxietyScore == 31) {
      videos = [
        [
          'https://www.youtube.com/watch?v=8-2WQF3SWwo',
          'LIVE Cognitive Behavioral Therapy Session by MedCircle'
        ],
        [
          'https://www.youtube.com/watch?v=BuTdBAM3rOw',
          'ASMR | Help for ANXIETY + Meditation (gentle rain 🌧️) by Sarah Lavender ASMR'
        ],
      ];
    } else if (anxietyScore == 32) {
      videos = [
        [
          'https://www.youtube.com/watch?v=LPvUZAlXxHs',
          'ASMR | CLICK THIS VIDEO FOR PANIC, ANXIETY, STRESS RELIEF ✅ by Karuna Satori ASMR'
        ],
        [
          'https://www.youtube.com/watch?v=L3hGIYl_htg',
          'ASMR for Anxiety ⛈ Calming Whispers & Guided Visualization for Sleep (Rain & Music Sounds) by Ozley ASMR'
        ]
      ];
    } else if (anxietyScore == 33) {
      videos = [
        [
          'https://www.youtube.com/watch?v=FKMrf3DdgWw',
          'ASMR for people with anxiety by Jojo\'s ASMR'
        ],
        [
          'https://www.youtube.com/watch?v=MIr3RsUWrdo',
          'Anxiety Relief Visualization: Peaceful Beach Meditation by Mindful Methods'
        ]
      ];
    } else if (anxietyScore == 34) {
      videos = [
        [
          'https://www.youtube.com/watch?v=2w3ZlSeFxQU',
          'Guided Visualization for Anxiety: Finding Your Safe Place by PsychotherapyNet'
        ],
        [
          'https://www.youtube.com/watch?v=yS_9Qtl6aqE',
          'Healing Light Visualization for Anxiety and Relaxation by Inner Harmony Meditation'
        ]
      ];
    } else if (anxietyScore == 35) {
      videos = [
        [
          'https://www.youtube.com/watch?v=O-6f5wQXSu8',
          'Let Go of Overthinking: Visualization Meditation to Calm Anxiety by Headspace'
        ],
        [
          'https://www.youtube.com/watch?v=vNeRn90QjyA',
          'Nature & Light Visualization for Anxiety Relief by Jason Stephenson'
        ]
      ];
    } else if (anxietyScore == 36) {
      videos = [
        [
          'https://www.youtube.com/watch?v=z39iodZOf00',
          'Anxiety & Stress Management with Floating Cloud Visualization by Relax With Me'
        ],
        [
          'https://www.youtube.com/watch?v=WGG7MGgptxE',
          'Visualization for Building Confidence and Overcoming Anxiety by Marisa Peer'
        ]
      ];
    } else if (anxietyScore == 37) {
      videos = [
        [
          'https://www.youtube.com/watch?v=nZP088xSDeQ',
          'Body Relaxation Visualizations for Anxiety Relief by The Relaxation Channel'
        ],
        [
          'https://www.youtube.com/watch?v=WGG7MGgptxE',
          'Visualization and Self-Hypnosis for Anxiety: Powerful Healing Technique by Michael Sealey'
        ]
      ];
    } else if (anxietyScore == 38) {
      videos = [
        [
          'https://www.youtube.com/watch?v=MdHXlAgUe9Y',
          'Light & Affirmation Meditation for Anxiety & Stress Relief by Calm Mind Hypnotherapy'
        ],
        [
          'https://www.youtube.com/watch?v=IZub-H2G4d4',
          '10 Minute Calming Progressive Muscle Relaxation To Ease Anxiety, Stress and Insomnia by Katie McLaughlin'
        ]
      ];
    } else if (anxietyScore == 39) {
      videos = [
        [
          'https://www.youtube.com/watch?v=e353-KuHhKc',
          'Reduce Anxiety & Improve Sleep With Progressive Muscle Relaxation + Giveaway! by Bob & Brad'
        ],
        [
          'https://www.youtube.com/watch?v=86HUcX8ZtAk',
          'PMR (Progressive Muscle Relaxation) to Help Release Tension, Relieve Anxiety or Insomnia by relax for a while'
        ]
      ];
    } else if (anxietyScore == 40) {
      videos = [
        [
          'https://www.youtube.com/watch?v=kdLTOurs2lA',
          'How to reduce stress with progressive muscle relaxation by Hamilton Health Sciences'
        ],
        [
          'https://www.youtube.com/watch?v=AJAyxihadh4',
          'Progressive Muscle Relaxation for Anxiety and Sleep by The Mindfulness App'
        ]
      ];
    } else if (anxietyScore == 41) {
      videos = [
        [
          'https://www.youtube.com/watch?v=Z21Xslddz3Y&t=45s',
          'Progressive Muscle Relaxation for Beginners by TherapyDen'
        ],
        [
          'https://www.youtube.com/watch?v=O-6f5wQXSu8',
          'Progressive Muscle Relaxation: A Powerful Tool for Relaxation and Sleep by Headspace'
        ]
      ];
    } else if (anxietyScore == 42) {
      videos = [
        [
          'https://www.youtube.com/watch?v=tmvzzbcLxwA',
          'Cognitive Behavioral Therapy Essentials | CBT Tools for Stress, Anxiety and Self Esteem by Doc Snipes'
        ],
        [
          'https://www.youtube.com/watch?v=86m4RC_ADEY',
          'Cognitive Behavioral Therapy for Anxiety Video by PsychotherapyNet'
        ]
      ];
    } else if (anxietyScore == 43) {
      videos = [
        [
          'https://www.youtube.com/watch?v=9c_Bv_FBE-c',
          'What is CBT? | Making Sense of Cognitive Behavioural Therapy by Mind, the mental health charity'
        ],
        [
          'https://www.youtube.com/watch?v=86m4RC_ADEY',
          'What is Cognitive Behavioral Therapy? by Psych Hub'
        ]
      ];
    } else if (anxietyScore == 44) {
      videos = [
        [
          'https://www.youtube.com/watch?v=8-2WQF3SWwo',
          'LIVE Cognitive Behavioral Therapy Session by MedCircle'
        ],
        [
          'https://www.youtube.com/watch?v=BuTdBAM3rOw',
          'ASMR | Help for ANXIETY + Meditation (gentle rain 🌧️) by Sarah Lavender ASMR'
        ]
      ];
    } else if (anxietyScore == 45) {
      videos = [
        [
          'https://www.youtube.com/watch?v=LPvUZAlXxHs',
          'ASMR | CLICK THIS VIDEO FOR PANIC, ANXIETY, STRESS RELIEF ✅ by Karuna Satori ASMR'
        ],
        [
          'https://www.youtube.com/watch?v=L3hGIYl_htg',
          'ASMR for Anxiety ⛈ Calming Whispers & Guided Visualization for Sleep (Rain & Music Sounds) by Ozley ASMR'
        ]
      ];
    } else if (anxietyScore == 46) {
      videos = [
        [
          'https://www.youtube.com/watch?v=FKMrf3DdgWw',
          'ASMR for people with anxiety by Jojo\'s ASMR'
        ],
        [
          'https://www.youtube.com/watch?v=MIr3RsUWrdo',
          'Anxiety Relief Visualization: Peaceful Beach Meditation by Mindful Methods'
        ]
      ];
    }
    if (anxietyScore == 47) {
      videos = [
        [
          'https://www.youtube.com/watch?v=2w3ZlSeFxQU',
          'Guided Visualization for Anxiety: Finding Your Safe Place by PsychotherapyNet'
        ],
        [
          'https://www.youtube.com/watch?v=yS_9Qtl6aqE',
          'Healing Light Visualization for Anxiety and Relaxation by Inner Harmony Meditation'
        ]
      ];
    } else if (anxietyScore == 48) {
      videos = [
        [
          'https://www.youtube.com/watch?v=O-6f5wQXSu8',
          'Let Go of Overthinking: Visualization Meditation to Calm Anxiety by Headspace'
        ],
        [
          'https://www.youtube.com/watch?v=vNeRn90QjyA',
          'Nature & Light Visualization for Anxiety Relief by Jason Stephenson'
        ]
      ];
    } else if (anxietyScore == 49) {
      videos = [
        [
          'https://www.youtube.com/watch?v=z39iodZOf00',
          'Anxiety & Stress Management with Floating Cloud Visualization by Relax With Me'
        ],
        [
          'https://www.youtube.com/watch?v=WGG7MGgptxE',
          'Visualization for Building Confidence and Overcoming Anxiety by Marisa Peer'
        ]
      ];
    } else if (anxietyScore == 50) {
      videos = [
        [
          'https://www.youtube.com/watch?v=nZP088xSDeQ',
          'Body Relaxation Visualizations for Anxiety Relief by The Relaxation Channel'
        ],
        [
          'https://www.youtube.com/watch?v=WGG7MGgptxE',
          'Visualization and Self-Hypnosis for Anxiety: Powerful Healing Technique by Michael Sealey'
        ]
      ];
    }
    return videos;
  }
}
