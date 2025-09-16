<template>
  <v-card @click="dialog = true">
    <v-img :src="getImageUrl(expe.img)" class="align-end" gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
      height="200px" cover>
      <v-card-title class="text-white">{{ expe.name }} ({{ expe.year }})</v-card-title>
      <template v-slot:placeholder>
        <div class="d-flex align-center justify-center fill-height">
          <v-progress-circular color="grey-lighten-4" indeterminate></v-progress-circular>
        </div>
      </template>
    </v-img>

    <!-- <v-card-actions>
              <v-spacer></v-spacer>

              <v-btn
                color="medium-emphasis"
                icon="mdi-heart"
                size="small"
              ></v-btn>

              <v-btn
                color="medium-emphasis"
                icon="mdi-bookmark"
                size="small"
              ></v-btn>

              <v-btn
                color="medium-emphasis"
                icon="mdi-share-variant"
                size="small"
              ></v-btn>
            </v-card-actions>-->
  </v-card>

  <v-dialog v-model="dialog" width="600">
    <v-card>
      <v-card-title>{{ expe.name }}</v-card-title>
      <v-img :src="getImageUrl(expe.img)" height="500px" contain></v-img>

      <v-card-text>
        <p><strong>Input:</strong> <v-chip color="primary" variant="flat" density="compact" v-for="input in expe.input">
            {{ input }}
          </v-chip></p>
        <p><strong>Output:</strong> <v-chip color="primary" variant="flat" density="compact" v-for="output in expe.output">
            {{ output }}
          </v-chip></p>
        <p><strong>Input technology:</strong> <v-chip color="primary" variant="flat" density="compact" v-for="recep_tech in expe.reception_technology">
            {{ recep_tech }}
          </v-chip></p>
        <p><strong>Display technology:</strong> <v-chip color="primary" variant="flat" density="compact" v-for="deliv_tech in expe.delivery_technology">
            {{ deliv_tech }}
          </v-chip></p>
        <p><strong>Object:</strong> <v-chip color="primary" variant="flat" density="compact" v-for="obj in expe.object">
            {{ obj }}
          </v-chip></p>
        <p><strong>References:</strong> {{ expe.reference }}</p>
        <p><strong>DOI:</strong> <a :href="doiLink">{{ expe.doi }}</a></p>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="primary" text @click="dialog = false">Close</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>

</template>

<script setup>
const props = defineProps(['expe'])

import { ref, computed } from 'vue'

const dialog = ref(false)

const doiLink = computed(() => {
  return `https://doi.org/${props.expe.doi}`;
});

function getImageUrl(name) {
  return new URL(`../assets/images/${name}`, import.meta.url).href
}

</script>