<template>
  <v-container max-width="900">
    <v-row>
      <v-col>
        <h1>Abstract</h1>
        <p>Physical objects enable more natural and embodied forms of digital engagement, and their integration through
          tangible interaction is increasingly recognized as a powerful way to enrich XR experiences. Yet, despite
          extensive research on tangible interfaces and XR systems, no unified framework exists to trace the evolution of these
          technologies and to guide the integration of tangible components into design projects.</p>
        <p>This paper addresses this gap by proposing a classification collating technical, functional and interactive
          features of tangible XR systems identified in the literature. Then, building on a systematic review of 227
          references, we trace the evolution of this field and analyze the resulting dataset to highlight dominant
          trends in current practices. An additional contribution is the implementation of TUI Explorer: an interactive, visual,
          and freely accessible database that enables designers and researchers to explore the various technologies
          available and support more informed design decisions.
        </p>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <h1>Peoples</h1>
      </v-col>
    </v-row>
    <v-row>
      <v-col v-for="(author, index) in authors" :key="index" cols="12" sm="6" md="6">
        <v-card>
          <v-card-item>
            <template v-slot:prepend>
              <v-avatar size="100" :image="getImageUrl(author.image)">
              </v-avatar>
            </template>
            <v-card-title>
              {{ author.name }}
            </v-card-title>

            <v-card-subtitle>
              {{ author.function }} <br/>
              {{ author.orga }}
            </v-card-subtitle>
          </v-card-item>
          <!-- <v-avatar size="80" :image="getImageUrl(author.image)"></v-avatar> -->
          <!-- <v-img height="150" :src="getImageUrl(author.image)"></v-img> -->
        </v-card>
      </v-col>

    </v-row>

  </v-container>
</template>

<script setup>
function getImageUrl(name) {
  return new URL(`../assets/images/${name}`, import.meta.url).href
}
const authors = [
  {
    name: "Alex GABRIEL, PhD",
    function: "Associate professor",
    orga: "Université de Lorraine, ERPI, F-54000, Nancy",
    image: "auth-Gabriel.png"

  },
  {
    name: "Anaelle HILY, PhD",
    function: "Associate professor",
    orga: "Université de Lorraine, ERPI, F-54000, Nancy",
    image: "auth-Hily.jpg"

  },
  {
    name: "Noham RODRIGUES",
    function: "Trainee",
    orga: "Université de Lorraine, ERPI, F-54000, Nancy / Esciencyel",
    image: "auth-Rodrigues.jpg"

  },
  {
    name: "Paul Hubert BAUDELET, PhD",
    function: "CEO",
    orga: "Esciencyel",
    image: "auth-Baudelet.jpg"

  }
] 
</script>