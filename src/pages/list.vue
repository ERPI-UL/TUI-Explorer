<template>
    <v-toolbar density="compact">
        <v-toolbar-title> Total : {{ sortedAndFilteredCards.length }}</v-toolbar-title>

        <v-spacer></v-spacer>
        <v-btn id="menu-activator" icon="mdi-sort">
        </v-btn>
        <v-menu activator="#menu-activator">
            <v-list>
                <v-list-item v-for="(item, index) in items" :key="index" :value="item.value" @click="item.action">
                    <template v-slot:prepend>
                        <v-icon :icon="item.prependIcon"></v-icon>
                    </template>
                    <v-list-item-title>{{ item.title }}</v-list-item-title>
                </v-list-item>
            </v-list>
        </v-menu>
        <v-btn icon="mdi-filter" @click.stop="filterPanelOpened = !filterPanelOpened"></v-btn>
    </v-toolbar>
    <v-container fluid>
        <v-row v-if="smAndDown && filterPanelOpened">
            <v-col>
                <v-card title="Filters">
                    <template v-slot:append>
                        <v-btn @click="removeFilter()" prepend-icon="mdi-filter-remove">Reset</v-btn>
                    </template>
                    <v-card-text>
                        <v-row>
                            <v-col>
                                <!-- {{ minYear }} -->
                                <v-range-slider v-model="selectedYears" step="1" :max="maxYear" :min="minYear"
                                    thumb-label="always"></v-range-slider>
                                <!-- {{ maxYear }} -->
                            </v-col>
                        </v-row>
                        <v-row dense>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Inputs</h3>
                                <v-checkbox v-for="input in inputs" :label="input" :value="input" density="compact"
                                    v-model="selectedInput" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Outputs</h3>
                                <v-checkbox v-for="output in outputs" :label="output" :value="output" density="compact"
                                    v-model="selectedOutputs" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Display technologies</h3>
                                <v-checkbox v-for="devTech in delivTechnologies" :label="devTech" :value="devTech"
                                    density="compact" v-model="selectedDevTech" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Input technologies</h3>
                                <v-checkbox v-for="recepTech in recepTechnologies" :label="recepTech" :value="recepTech"
                                    density="compact" v-model="selectedRecepTech" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Objects</h3>
                                <v-checkbox v-for="object in objects" :label="object" :value="object" density="compact"
                                    v-model="selectedObject" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Origins</h3>
                                <v-checkbox v-for="origin in origins" :label="origin" :value="origin" density="compact"
                                    v-model="selectedOrigin" hide-details></v-checkbox>
                            </v-col>

                        </v-row>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>


        <v-row class="full-height">
            <v-col cols="12" :md="filterPanelOpened ? 8 : 12">
                <v-row dense>
                    <v-col v-for="(card, index) in sortedAndFilteredCards" :key="index" cols="12" md="4">
                        <expe-card :expe="card"></expe-card>
                    </v-col>
                </v-row>
            </v-col>
            <v-col v-if="filterPanelOpened && mdAndUp" cols="12" md="4">
                <v-card title="Filters">
                    <template v-slot:append>
                        <v-btn @click="removeFilter()" prepend-icon="mdi-filter-remove">Reset</v-btn>
                    </template>
                    <v-card-text>
                        <v-row>
                            <v-col>
                                <!-- {{ minYear }} -->
                                <v-range-slider v-model="selectedYears" step="1" :max="maxYear" :min="minYear"
                                    thumb-label="always"></v-range-slider>
                                <!-- {{ maxYear }} -->
                            </v-col>
                        </v-row>
                        <v-row dense>
                            <v-col class="mb-4" cols="4">
                                <h3>Inputs</h3>
                                <v-checkbox v-for="input in inputs" :label="input" :value="input" density="compact"
                                    v-model="selectedInput" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Outputs</h3>
                                <v-checkbox v-for="output in outputs" :label="output" :value="output" density="compact"
                                    v-model="selectedOutputs" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Display technologies</h3>
                                <v-checkbox v-for="devTech in delivTechnologies" :label="devTech" :value="devTech"
                                    density="compact" v-model="selectedDevTech" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Input technologies</h3>
                                <v-checkbox v-for="recepTech in recepTechnologies" :label="recepTech" :value="recepTech"
                                    density="compact" v-model="selectedRecepTech" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Objects</h3>
                                <v-checkbox v-for="object in objects" :label="object" :value="object" density="compact"
                                    v-model="selectedObject" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Origins</h3>
                                <v-checkbox v-for="origin in origins" :label="origin" :value="origin" density="compact"
                                    v-model="selectedOrigin" hide-details></v-checkbox>
                            </v-col>

                        </v-row>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
        <!-- <v-btn v-show="true" color="primary" dark fab fixed bottom right @click="scrollToTop" icon="mdi-chevron-up"></v-btn> -->
        <v-fab key="fab" app v-show="showFab" location="bottom left" size="large" icon="mdi-chevron-up" @click="scrollToTop"></v-fab>
    </v-container>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import expeCard from '@/components/ExpeCard.vue'
import data from '@/assets/dataTUI-v2.json';
import { useDisplay } from 'vuetify'

// Destructure only the keys you want to use
const { smAndDown, mdAndUp } = useDisplay()

// Define all ref variables first
const showFab =ref(false)
const selectedYears = ref([1950, 2030])
const filterPanelOpened = ref(true)
const selectedInput = ref(['Non Linear', 'Linear', 'Rotational', 'Binary', 'Free'])
const selectedOutputs = ref(['Audio', 'Haptic', 'Visual'])
const selectedDevTech = ref(['Wearables', 'Projection', 'Handheld object', 'Overlay AR'])
const selectedRecepTech = ref(['Computer Vision', 'Microcontrollers, Sensors, and Actuators', 'RFID'])
const selectedObject = ref(['Geometric', 'Controller', 'Display', 'Organic', 'Non shape retaining', 'Shape retaining'])
const selectedOrigin = ref(['Academic', 'Industry', 'Hobbyist'])

// Variables pour le tri
const sortType = ref('none')


const items = [
    {
        title: 'Asc. alpha. order',
        value: 1,
        action: ascAlphaOrder,
        prependIcon: 'mdi-order-alphabetical-ascending',
    },
    {
        title: 'Desc. alpha. order',
        value: 2,
        action: descAlphaOrder,
        prependIcon: 'mdi-order-alphabetical-descending',
    },
    {
        title: 'Asc. year order',
        value: 3,
        action: ascYearOrder,
        prependIcon: 'mdi-order-numeric-ascending',
    },
    {
        title: 'Desc. year order',
        value: 4,
        action: descYearOrder,
        prependIcon: 'mdi-order-numeric-descending',
    }
]

const cards = ref(data)

const yearFilteredCards = computed(() => {
    return cards.value.filter(card => {
        const year = card.year || 0;
        return year >= selectedYears.value[0] && year <= selectedYears.value[1];
    });
});

const inputFilteredCards = computed(() => {
    return yearFilteredCards.value.filter(card => {
        if (!card.input || !Array.isArray(card.input)) return false;
        return card.input.some(input => selectedInput.value.includes(input));
    });
});

const outputfilteredCards = computed(() => {
    return inputFilteredCards.value.filter(card => {
        if (!card.output || !Array.isArray(card.output)) return false;
        return card.output.some(output => selectedOutputs.value.includes(output));
    });
});

const delivTechfilteredCards = computed(() => {
    return outputfilteredCards.value.filter(card => {
        if (!card.delivery_technology || !Array.isArray(card.delivery_technology)) return false;
        return card.delivery_technology.some(delivTech => selectedDevTech.value.includes(delivTech));
    });
});

const recepTechfilteredCards = computed(() => {
    return delivTechfilteredCards.value.filter(card => {
        if (!card.reception_technology || !Array.isArray(card.reception_technology)) return false;
        return card.reception_technology.some(recepTech => selectedRecepTech.value.includes(recepTech));
    });
});

const filteredCards = computed(() => {
    return recepTechfilteredCards.value.filter(card => {
        if (!card.object || !Array.isArray(card.object)) return false;
        return card.object.some(obj => selectedObject.value.includes(obj));
    });
});

const sortedAndFilteredCards = computed(() => {
    const cardsToSort = [...filteredCards.value]; // Créer une copie pour éviter de muter l'original

    switch (sortType.value) {
        case 'title-asc':
            return cardsToSort.sort((a, b) => {
                const nameA = a.name?.toLowerCase() || '';
                const nameB = b.name?.toLowerCase() || '';
                return nameA.localeCompare(nameB);
            });

        case 'title-desc':
            return cardsToSort.sort((a, b) => {
                const nameA = a.name?.toLowerCase() || '';
                const nameB = b.name?.toLowerCase() || '';
                return nameB.localeCompare(nameA);
            });

        case 'year-asc':
            return cardsToSort.sort((a, b) => {
                const yearA = a.year || 0;
                const yearB = b.year || 0;
                return yearA - yearB;
            });

        case 'year-desc':
            return cardsToSort.sort((a, b) => {
                const yearA = a.year || 0;
                const yearB = b.year || 0;
                return yearB - yearA;
            });

        default:
            return cardsToSort; // Pas de tri
    }
});

const minYear = computed(() => {
    const validYears = cards.value
        .filter(card => typeof card.year === 'number' && card.year > 0)
        .map(card => card.year);
    return validYears.length > 0 ? Math.min(...validYears) : 1950;
});

const maxYear = computed(() => {
    const validYears = cards.value
        .filter(card => typeof card.year === 'number' && card.year > 0)
        .map(card => card.year);
    return validYears.length > 0 ? Math.max(...validYears) : 2030;
});

onMounted(() => {
  window.addEventListener('scroll', handleScroll);
});

onBeforeUnmount(() => {
  window.removeEventListener('scroll', handleScroll);
});

function handleScroll() {
  // Afficher le FAB lorsque l'utilisateur est plus bas que 20% de la hauteur de la page
  showFab.value = window.scrollY > 200
}

function scrollToTop() {
  // Scroller jusqu'en haut de la page en animant le mouvement
  window.scrollTo({
    top: 0,
    behavior: 'smooth',
  });
}

function removeFilter() {
    selectedInput.value = inputs.map(v => v);
    selectedOutputs.value = outputs.map(v => v);
    selectedDevTech.value = delivTechnologies.map(v => v);
    selectedRecepTech.value = recepTechnologies.map(v => v);
    selectedObject.value = objects.map(v => v);
    selectedOrigin.value = origins.map(v => v);
    selectedYears.value = [minYear.value, maxYear.value];
}

// Fonctions de tri
function ascAlphaOrder() {
    sortType.value = 'title-asc'
}

function descAlphaOrder() {
    sortType.value = 'title-desc'
}

function ascYearOrder() {
    sortType.value = 'year-asc'
}

function descYearOrder() {
    sortType.value = 'year-desc'
}

const inputs = ['Non Linear', 'Linear', 'Rotational', 'Binary', 'Free']
const outputs = ['Audio', 'Haptic', 'Visual']
const origins = ['Academic', 'Industry', 'Hobbyist']
const delivTechnologies = ['Wearables', 'Projection', 'Handheld object', 'Overlay AR']
const recepTechnologies = ['Computer Vision', 'Microcontrollers, Sensors, and Actuators', 'RFID']
const objects = ['Geometric', 'Controller', 'Display', 'Organic', 'Non shape retaining', 'Shape retaining']
</script>